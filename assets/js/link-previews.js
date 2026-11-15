(function () {
  var root = document.querySelector(".post-content");
  var dataNode = document.getElementById("link-preview-data");
  if (!root || !dataNode) {
    return;
  }

  var data;
  try {
    data = JSON.parse(dataNode.textContent);
  } catch (error) {
    return;
  }

  var posts = data.posts || {};
  var xPosts = data.x || {};
  var reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)");
  var card = document.createElement("div");
  card.className = "link-preview";
  card.setAttribute("aria-hidden", "true");
  document.body.appendChild(card);

  var openLink = null;
  var pendingLink = null;
  var focusLink = null;
  var suppressed = null;
  var pointerOnLink = false;
  var pointerOnCard = false;
  var showTimer = 0;
  var hideTimer = 0;

  function clean(value) {
    return String(value || "").replace(/\s+/g, " ").trim();
  }

  function postText(value) {
    var text = clean(value);
    var statement = text.replace(/^(?:@[A-Za-z0-9_]+\s+)+/, "");
    return statement || text;
  }

  function formatDate(value) {
    if (!value) {
      return "";
    }
    try {
      var date = new Date(value);
      if (isNaN(date.getTime())) {
        return "";
      }
      return new Intl.DateTimeFormat("en-US", {
        timeZone: "America/New_York",
        month: "long",
        day: "numeric",
        year: "numeric"
      }).format(date);
    } catch (error) {
      return "";
    }
  }

  function linkOf(node) {
    if (!node || !node.closest) {
      return null;
    }
    var link = node.closest("a[href]");
    if (!link || !root.contains(link)) {
      return null;
    }
    return link;
  }

  function sitePath(url) {
    var path = url.pathname;
    if (path.length > 1 && path.charAt(path.length - 1) === "/") {
      path = path.slice(0, -1);
    }
    return path;
  }

  function lookup(link) {
    var url;
    try {
      url = new URL(link.getAttribute("href"), window.location.href);
    } catch (error) {
      return null;
    }

    var host = url.hostname.toLowerCase().replace(/^(?:www|mobile)\./, "");
    var path = sitePath(url);
    var onSite = url.origin === window.location.origin || host === "jamesonstone.io";
    if (onSite && Object.prototype.hasOwnProperty.call(posts, path)) {
      var post = posts[path];
      return {
        kind: "post",
        title: clean(post.title),
        date: clean(post.date),
        excerpt: clean(post.excerpt)
      };
    }

    if (host !== "x.com" && host !== "twitter.com") {
      return null;
    }

    var webStatus = path.match(/^\/i\/web\/status\/(\d+)/);
    var userStatus = path.match(/^\/([A-Za-z0-9_]{1,15})\/status\/(\d+)/);
    var id = webStatus ? webStatus[1] : userStatus && userStatus[2];
    if (!id || !Object.prototype.hasOwnProperty.call(xPosts, id)) {
      return null;
    }

    var item = xPosts[id];
    var handle = clean(item.handle) || (userStatus ? userStatus[1] : "");
    return {
      kind: "x",
      author: clean(item.author),
      handle: handle,
      date: formatDate(item.created_at),
      text: postText(item.text)
    };
  }

  function addLine(className, text) {
    if (!text) {
      return;
    }
    var node = document.createElement("p");
    node.className = className;
    node.textContent = text;
    card.appendChild(node);
  }

  function render(preview) {
    while (card.firstChild) {
      card.removeChild(card.firstChild);
    }
    if (preview.kind === "post") {
      addLine("link-preview__meta", preview.date);
      addLine("link-preview__title", preview.title);
      addLine("link-preview__excerpt", preview.excerpt);
      return;
    }

    var name = preview.author || (preview.handle ? "@" + preview.handle : "");
    addLine("link-preview__title", name);
    var meta = [];
    if (preview.author && preview.handle) {
      meta.push("@" + preview.handle);
    }
    if (preview.date) {
      meta.push(preview.date);
    }
    addLine("link-preview__meta", meta.join(" · "));
    addLine("link-preview__text", preview.text);
  }

  function hide() {
    window.clearTimeout(showTimer);
    window.clearTimeout(hideTimer);
    pendingLink = null;
    openLink = null;
    pointerOnCard = false;
    card.classList.remove("is-open");
  }

  function place(link) {
    var rect = link.getBoundingClientRect();
    if (rect.bottom <= 0 || rect.top >= window.innerHeight) {
      hide();
      return;
    }
    var margin = 10;
    var top = rect.bottom + 8;
    var height = card.offsetHeight;
    if (top + height > window.innerHeight - margin) {
      top = rect.top - height - 8;
    }
    if (top < margin) {
      top = margin;
    }
    var left = rect.left;
    var width = card.offsetWidth;
    if (left + width > window.innerWidth - margin) {
      left = window.innerWidth - margin - width;
    }
    if (left < margin) {
      left = margin;
    }
    card.dataset.placement = top >= rect.bottom ? "below" : "above";
    card.style.top = top + "px";
    card.style.left = left + "px";
  }

  function armHide(link) {
    window.clearTimeout(hideTimer);
    var delay = reduceMotion.matches ? 0 : 280;
    hideTimer = window.setTimeout(function () {
      if (pointerOnCard || (pointerOnLink && openLink === link) || focusLink === link) {
        return;
      }
      if (focusLink && suppressed !== focusLink) {
        show(focusLink);
        return;
      }
      if (openLink === link) {
        hide();
      }
    }, delay);
  }

  function show(link) {
    if (suppressed === link) {
      return;
    }
    var preview = lookup(link);
    var usable = preview && (preview.kind === "post" ? preview.title : preview.text);
    if (!usable) {
      return;
    }
    window.clearTimeout(hideTimer);
    render(preview);
    openLink = link;
    pendingLink = null;
    place(link);
    if (openLink !== link) {
      return;
    }
    card.classList.add("is-open");
    window.requestAnimationFrame(function () {
      if (openLink === link) {
        place(link);
      }
    });
  }

  function scheduleShow(link) {
    if (suppressed === link) {
      return;
    }
    window.clearTimeout(hideTimer);
    if (openLink === link || pendingLink === link) {
      return;
    }
    window.clearTimeout(showTimer);
    if (openLink) {
      openLink = null;
      card.classList.remove("is-open");
    }
    pendingLink = link;
    var delay = reduceMotion.matches ? 0 : 180;
    showTimer = window.setTimeout(function () {
      pendingLink = null;
      show(link);
    }, delay);
  }

  function clearSuppressed(link) {
    if (suppressed === link) {
      suppressed = null;
    }
  }

  root.addEventListener("pointerover", function (event) {
    if (event.pointerType !== "mouse") {
      return;
    }
    var link = linkOf(event.target);
    if (!link) {
      return;
    }
    if (suppressed && suppressed !== link) {
      suppressed = null;
    }
    pointerOnLink = true;
    scheduleShow(link);
  });

  root.addEventListener("pointerout", function (event) {
    if (event.pointerType !== "mouse") {
      return;
    }
    var link = linkOf(event.target);
    if (!link) {
      return;
    }
    if (event.relatedTarget && link.contains(event.relatedTarget)) {
      return;
    }
    pointerOnLink = false;
    clearSuppressed(link);
    if (event.relatedTarget && card.contains(event.relatedTarget)) {
      pointerOnCard = true;
      window.clearTimeout(showTimer);
      window.clearTimeout(hideTimer);
      return;
    }
    if (pendingLink === link) {
      window.clearTimeout(showTimer);
      pendingLink = null;
    }
    if (openLink !== link || focusLink === link) {
      return;
    }
    armHide(link);
  });

  card.addEventListener("pointerover", function (event) {
    if (event.pointerType !== "mouse") {
      return;
    }
    pointerOnCard = true;
    window.clearTimeout(hideTimer);
  });

  card.addEventListener("pointerout", function (event) {
    if (event.pointerType !== "mouse") {
      return;
    }
    if (event.relatedTarget && card.contains(event.relatedTarget)) {
      return;
    }
    pointerOnCard = false;
    if (event.relatedTarget && openLink && openLink.contains(event.relatedTarget)) {
      pointerOnLink = true;
      window.clearTimeout(hideTimer);
      return;
    }
    if (!openLink || focusLink === openLink) {
      return;
    }
    armHide(openLink);
  });

  root.addEventListener("focusin", function (event) {
    var link = linkOf(event.target);
    if (!link || !link.matches(":focus-visible")) {
      return;
    }
    focusLink = link;
    window.clearTimeout(showTimer);
    window.clearTimeout(hideTimer);
    show(link);
  });

  root.addEventListener("focusout", function (event) {
    var link = linkOf(event.target);
    if (!link) {
      return;
    }
    if (event.relatedTarget && link.contains(event.relatedTarget)) {
      return;
    }
    clearSuppressed(link);
    if (focusLink === link) {
      focusLink = null;
    }
    if (pointerOnLink || pointerOnCard) {
      return;
    }
    if (openLink === link) {
      hide();
    }
  });

  document.addEventListener("keydown", function (event) {
    if (event.key !== "Escape" || !openLink) {
      return;
    }
    suppressed = openLink;
    hide();
  });

  window.addEventListener("scroll", function () {
    if (openLink) {
      place(openLink);
    }
  }, { passive: true });

  window.addEventListener("resize", function () {
    if (openLink) {
      place(openLink);
    }
  });
}());
