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
          <template class="ant-card-actions" slot="actions">
            <a-icon type="like" v-on:click="likePicture(item)"/>
            <a-icon type="dislike" v-on:click="dislikePicture(item)"/>
          </template>
          <a-card-meta>
            <template
              slot="title"
            >{{item.attributes.user_full_name | capitalize}}, {{item.attributes.user_age}}</template>
            <template slot="description">City: {{item.attributes.user_city | capitalize}}</template>
          </a-card-meta>
        </a-card>
      </a-col>
      <a-divider v-if="profilePictures.length > 0"/>
    </a-row>
  </div>
</template>

<script>
import Vue from "vue";
import { Card, Icon, Avatar, Row, Col, Divider } from "ant-design-vue";
import VueResource from "vue-resource";

Vue.use(Card);
Vue.use(Icon);
Vue.use(Avatar);
Vue.use(Row);
Vue.use(Divider);
Vue.use(Col);

Vue.use(VueResource);

let customActions = {
  like: { method: "POST", url: "profile_pictures{/id}/like" },
  dislike: { method: "POST", url: "profile_pictures{/id}/dislike" }
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
      profilePictures: {},
      visible: false,
      type: "success",
      message: "",
      description: ""
    };
  },

  mounted() {
    Vue.http.headers.common["X-CSRF-Token"] = Rails.csrfToken();
    this.fetchProfiles();
  },
  methods: {
    fetchProfiles() {
      resource.get().then(
        response => {
          this.profilePictures = response.body.data;
        },
        response => {
          console.error(response);
        }
      );
    },
    likePicture(picture) {
      resource.like({ id: picture.id }, {}).then(
        response => {
          console.log(response.body.data);
          this.removePicture(picture);
        },
        response => {
          // error callback
        }
      );
    },
    dislikePicture(picture) {
      resource.dislike({ id: picture.id }, {}).then(
        response => {
          console.log(response.body.data);
          this.removePicture(picture);
        },
        response => {
          // error callback
        }
      );
    },
    removePicture(picture) {
      this.profilePictures.splice(this.profilePictures.indexOf(picture), 1);
    }
  }
};
</script>
<style lang="css" scoped>
.box {
  border: 2px solid;
  border-radius: 25px;
  color: purple;
  width: 120px;
}
.ant-card-meta-description {
  color: rgba(27, 137, 180, 0.45);
  height: 44px;
  line-height: 22px;
  overflow: hidden;
}
#ant-card-meta-description {
  color: rgba(27, 137, 180, 0.45);
  height: 44px;
  line-height: 22px;
  overflow: hidden;
}
</style>
