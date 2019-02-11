<template>
  <div id="app">
    <a-menu v-model="current" mode="horizontal">
      <a-menu-item key="home">
        <a href="/users/sign_in" rel="noopener noreferrer">
          <a-icon type="login"/>Login
        </a>
      </a-menu-item>
    </a-menu>
  </div>
</template>
<script>
export default {
  data() {
    return {
      current: ["home"],
      name: 'Welcome'
    };
  }
};
</script>