<template>
  <a-layout id="components-dashboard" class="layout">
    <a-layout-header theme="light" class="header">
      <a-menu
        v-model="current"
        mode="horizontal"
        theme="dark"
        :style="{ lineHeight: '64px' }"
        @click="onclick"
      >
        <a-menu-item key="home">
          <router-link to="/">Home</router-link>
        </a-menu-item>
        <a-menu-item key="Profile">
          <router-link to="/users">My profile</router-link>
        </a-menu-item>
        <a-menu-item key="Profiles">
          <router-link to="/profiles">Profiles</router-link>
        </a-menu-item>
        <a-menu-item key="MostRated">
          <router-link to="/mostRatedPictures">Most Rated Pictures</router-link>
        </a-menu-item>
        <a-menu-item key="ChatRoom">
          <router-link to="/chatRoom">ChatRoom</router-link>
        </a-menu-item>
        <a-menu-item key="Activity">
          <router-link to="/activities">Activity</router-link>
        </a-menu-item>
        <a-menu-item key="logout">
          <a href="/users/sign_out" rel="noopener noreferrer" data-method="delete">
            <a-icon type="logout"/>Logout
          </a>
        </a-menu-item>
      </a-menu>
    </a-layout-header>
    <a-layout-content style="padding: 0 50px">
      <div :style="{ background: '#fff', padding: '24px', minHeight: '400px' }">
        <router-view></router-view>
      </div>
    </a-layout-content>
    <a-layout-footer style="text-align: center">Ant Design ©2018 Created by Ant UED</a-layout-footer>
  </a-layout>
</template>

<script>
export default {
  data() {
    return {
      current: ["home"],
      name: "Dashboard"
    };
  },
  methods: {
    onclick(item) {
      this.current = [item.key];
    }
  }
};
</script>

<style>
#components-dashboard .header {
  background: #ffffff !important;
  padding: 0 50px;
  height: 64px;
  line-height: 64px;
}
</style>