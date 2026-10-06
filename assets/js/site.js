(function () {
  var safeHeaderEmojis = ["✨", "📚", "📝", "💡", "🎨", "🧭", "🌿", "☕", "🪐", "💎"];
  var homeTaglines = ["Just put the AGI in the bag, bro.", "p(doom) = 0", "Let 👏 the 👏 RSI 👏 cook 👏", "model safety is an engineering problem"];

  function getLastValue(storageKey) {
    try {
      return window.sessionStorage.getItem(storageKey);
    } catch (_error) {
      return null;
    }
  }

  function setLastValue(storageKey, value) {
    try {
      window.sessionStorage.setItem(storageKey, value);
    } catch (_error) {
      return;
    }
  }

  function pickValue(values, lastValue) {
    var choices = values.filter(function (value) {
      return value !== lastValue;
    });
    var pool = choices.length > 0 ? choices : values;
    var index = Math.floor(Math.random() * pool.length);

    return pool[index];
  }

  function rotateText(selector, values, storageKey) {
    var target = document.querySelector(selector);
    if (!target) {
      return;
    }

    var lastValue = getLastValue(storageKey) || target.textContent.trim();
    var value = pickValue(values, lastValue);
    target.textContent = value;
    setLastValue(storageKey, value);
  }

  function rotateAll() {
    rotateText("[data-random-header-emoji]", safeHeaderEmojis, "jamesonstone.headerEmoji");
    rotateText("[data-random-tagline]", homeTaglines, "jamesonstone.homeTagline");
  }

  rotateAll();
  window.addEventListener("pageshow", function (event) {
    if (event.persisted) {
      rotateAll();
    }
  });
}());
