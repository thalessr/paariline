<template>
  <div id="app">
    <a-menu v-model="current" mode="horizontal">
      <a-menu-item key="logout">
        <a href="/users/sign_out" rel="noopener noreferrer" data-method="delete">
          <a-icon type="logout"/>Logout
        </a>
      </a-menu-item>
    </a-menu>
  </div>
</template>
<script>
export default {
  data() {
    return {
      current: ["logout"]
    };
  }
};
</script>