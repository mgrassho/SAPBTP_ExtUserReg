<script setup lang="ts"></script>

<template>
  <div class="message">
    <h3>
      Your request has been received.<br />
      Thank you very much.<br />
      <a href="javascript:history.back()">Click to create another request</a>
    </h3>
  </div>
</template>

<style scoped>
.message {
  display: flex;
  font-size: 2rem;
  font-weight: 500;
  margin-bottom: 0.4rem;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: var(--color-text);
}

a {
  font-size: 1.3rem;
}
</style>
