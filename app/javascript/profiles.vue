<template>
  <div>
    <a-card
      hoverable
      style="width: 300px"
      v-for="(item, index) in profilePictures"
      v-bind:item="item"
      v-bind:index="index"
      v-bind:key="item.id"
    >
      <img alt="example" v-bind:src="item.attributes.picture_url" slot="cover">
      <template class="ant-card-actions" slot="actions">
        <a-icon type="like" v-on:click="likePicture(item.id)"/>
        <a-icon type="dislike"/>
      </template>
      {{item.attributes.user_full_name | capitalize}}
      {{item.attributes.user_age}}
    </a-card>
  </div>
</template>

<script>
import Vue from "vue";
import { Card, Icon, Avatar } from "ant-design-vue";
import VueResource from "vue-resource";

Vue.use(Card);
Vue.use(Icon);
Vue.use(Avatar);
Vue.use(VueResource);

Vue.http.headers.common["X-CSRF-Token"] = document
  .querySelector('meta[name="csrf-token"]')
  .getAttribute("content");

let customActions = {
  like: { method: "POST", url: "profile_pictures{/id}/like" },
  dislike: { method: "POST", url: "profile_pictures{/id}/dislike" }
};
var resource = Vue.resource("profile_pictures{/id}", {}, customActions);
export default {
  data() {
    return {
      profilePictures: {},
      visible: false,
      type: "success",
      message: "",
      description: "",
      filters: {
        capitalize: function(value) {
          if (!value) return "";
          value = value.toString();
          return value.charAt(0).toUpperCase() + value.slice(1);
        }
      }
    };
  },

  mounted() {
    this.fetchProfiles();
  },
  methods: {
    fetchProfiles() {
      resource.get().then(
        response => {
          console.log(response.body.data);
          this.profilePictures = response.body.data;
        },
        response => {
          console.error(response);
        }
      );
    },
    likePicture(pictureId) {
      resource.like({ id: pictureId }, {}).then(
        response => {
          console.log(response.body.data);
        },
        response => {
          // error callback
        }
      );
    },
    dislike() {},
    displayMessage(messageType, message, description) {
      this.type = messageType;
      this.message = message;
      this.visible = true;
      this.description = description;
    }
  }
};
</script>
