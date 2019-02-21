<template>
  <a-layout id="components-dashboard" class="layout">
    <a-layout-header theme="light" :class="layout">
      <a-menu
        v-model="current"
        mode="horizontal"
        theme="light"
        :style="{ lineHeight: '64px' }"
        @click="onclick"
      >
        <a-menu-item key="home">
          <router-link to="/">Home</router-link>
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
        <a-dropdown
          style="display: inline-block; height: 100%; vertical-align: initial; float: right"
        >
          <span style="cursor: pointer">
            <a-icon type="profile"/>
            <span>My profile</span>
          </span>
          <a-menu style="width: 150px" slot="overlay">
            <a-menu-item>
              <router-link to="/users">
                <a-icon type="setting" key="MyProfile"/>
                <span>Edit</span>
              </router-link>
            </a-menu-item>
            <a-menu-divider/>
            <a-menu-item key="logout">
              <a href="/users/sign_out" rel="noopener noreferrer" data-method="delete">
                <a-icon type="poweroff"/>
                <span>Logout</span>
              </a>
            </a-menu-item>
          </a-menu>
        </a-dropdown>
      </a-menu>
    </a-layout-header>
    <a-layout-content style="padding: 0 50px">
      <a-breadcrumb style="margin: 16px 0">
        <a-breadcrumb-item :key="item.path" v-for="(item, index) in breadcrumb">
          <span>{{item.name}}</span>
        </a-breadcrumb-item>
      </a-breadcrumb>
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
      name: "Dashboard",
      breadcrumb: []
    };
  },
  mounted() {
    this.getBreadcrumb();
  },
  updated() {
    this.getBreadcrumb();
  },
  methods: {
    onclick(item) {
      this.current = [item.key];
    },
    getBreadcrumb() {
      this.breadcrumb = this.$route.matched;
    }
  }
};
</script>

<style>
.layout {
  background: #fefefe;
  padding: 0 50px;
  height: 64px;
  line-height: 64px;
}
</style>