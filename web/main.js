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

// Screenshot tabs.
const tabs = document.querySelectorAll(".shot-tabs button");
tabs.forEach((tab) => tab.addEventListener("click", () => {
  tabs.forEach((t) => t.setAttribute("aria-selected", String(t === tab)));
  document.querySelectorAll(".shot").forEach((img) => img.classList.toggle("on", img.id === tab.dataset.shot));
}));

document.getElementById("year").textContent = new Date().getFullYear();
