// Fade sections in as they scroll into view.
const items = document.querySelectorAll(".reveal");
if ("IntersectionObserver" in window) {
  const io = new IntersectionObserver((entries) => {
    for (const e of entries) {
      if (e.isIntersecting) {
        e.target.classList.add("in");
        io.unobserve(e.target);
      }
    }
  }, { rootMargin: "0px 0px -8% 0px", threshold: 0.08 });
  items.forEach((el) => io.observe(el));
} else {
  items.forEach((el) => el.classList.add("in"));
}

// Live clock in the desktop preview.
const clock = document.getElementById("clock");
function tick() {
  const now = new Date();
  const day = now.toLocaleDateString(undefined, { weekday: "short" });
  const time = now.toLocaleTimeString(undefined, { hour: "numeric", minute: "2-digit" });
  clock.textContent = `${day} ${time}`;
}
if (clock) {
  tick();
  setInterval(tick, 30_000);
}

document.getElementById("year").textContent = new Date().getFullYear();
