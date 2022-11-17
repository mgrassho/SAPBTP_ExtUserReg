import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import ConfirmationMessage from "../views/ConfirmationView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/confirmation",
      name: "confirmation",
      component: ConfirmationMessage,
    }
  ],
});

export default router;
