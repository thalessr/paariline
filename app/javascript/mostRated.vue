<template>
  <div style="background-color: #ececec; padding: 20px;">
    <a-row :gutter="16">
      <a-col
        style="margin-bottom: 20px"
        :span="8"
        v-for="(item, index) in profilePictures"
        v-bind:item="item"
        v-bind:index="index"
        v-bind:key="item.id"
      >
        <a-card hoverable style="width: 300px">
          <img alt="example" :src="item.attributes.picture_url" slot="cover">
          <a-card-meta>
            <template
              slot="title"
            >{{item.attributes.user_full_name | capitalize}}, {{item.attributes.user_age}}</template>
            <template slot="description">Number of likes
              <a-badge
                showZero
                :count="item.attributes.like_count"
                :numberStyle="{backgroundColor: '#52c41a'}"
              />
            </template>
          </a-card-meta>
        </a-card>
      </a-col>
      <a-divider/>
    </a-row>
  </div>
</template>

<script>
import Vue from "vue";
import { Card, Icon, Row, Col, Divider, Badge } from "ant-design-vue";
import VueResource from "vue-resource";

Vue.use(Card);
Vue.use(Icon);
Vue.use(Row);
Vue.use(Divider);
Vue.use(Col);
Vue.use(Badge);

Vue.use(VueResource);

Vue.http.headers.common["X-CSRF-Token"] = document
  .querySelector('meta[name="csrf-token"]')
  .getAttribute("content");

let customActions = {
  mostRated: { method: "GET", url: "/profile_pictures/most_rated" }
};
var resource = Vue.resource("profile_pictures{/id}", {}, customActions);
export default {
  name: "Profiles",
  filters: {
    capitalize: function(value) {
      if (!value) return "";
      value = value.toString();
      return value.charAt(0).toUpperCase() + value.slice(1);
    }
  },
  data() {
    return {
      profilePictures: {}
    };
  },

  mounted() {
    this.fetchProfiles();
  },
  methods: {
    fetchProfiles() {
      resource.mostRated().then(
        response => {
          this.profilePictures = response.body.data;
        },
        response => {
          console.error(response);
        }
      );
    }
  }
};
</script>
<style scoped>
.box {
  border: 2px solid;
  border-radius: 25px;
  color: purple;
  width: 120px;
}
</style>
