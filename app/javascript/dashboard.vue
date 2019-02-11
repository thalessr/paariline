<template>
  <div id="app">
    <a-menu v-model="current" mode="horizontal">
      <a-menu-item key="Hello">
        <router-link :to="{ name: 'Hello' }">Home</router-link>
       </a-menu-item>
       <a-menu-item key="About">
       <router-link to="/about">About</router-link>
       </a-menu-item>
      <a-menu-item key="logout">
        <a href="/users/sign_out" rel="noopener noreferrer" data-method="delete">
          <a-icon type="logout"/>Logout
        </a>
      </a-menu-item>
    </a-menu>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app'
}
</script>