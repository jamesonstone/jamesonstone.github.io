(function () {
  var safeHeaderEmojis = ["✨", "📚", "📝", "💡", "🎨", "🧭", "🌿", "☕", "🪐", "💎"];
  var storageKey = "jamesonstone.headerEmoji";

  function getLastEmoji() {
    try {
      return window.sessionStorage.getItem(storageKey);
    } catch (_error) {
      return null;
    }
  }

  function setLastEmoji(emoji) {
    try {
      window.sessionStorage.setItem(storageKey, emoji);
    } catch (_error) {
      return;
    }
  }

  function pickEmoji() {
    var lastEmoji = getLastEmoji();
    var choices = safeHeaderEmojis.filter(function (emoji) {
      return emoji !== lastEmoji;
    });
    var emojiPool = choices.length > 0 ? choices : safeHeaderEmojis;
    var index = Math.floor(Math.random() * emojiPool.length);

    return emojiPool[index];
  }

  function setHeaderEmoji() {
    var emojiTarget = document.querySelector("[data-random-header-emoji]");
    if (!emojiTarget) {
      return;
    }

    var emoji = pickEmoji();
    emojiTarget.textContent = emoji;
    setLastEmoji(emoji);
  }

  setHeaderEmoji();
  window.addEventListener("pageshow", function (event) {
    if (event.persisted) {
      setHeaderEmoji();
    }
  });
}());
