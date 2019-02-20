<template>
  <a-timeline mode="alternate">
    <a-timeline-item
      v-for="(item, index) in timelineItems"
      v-bind:item="item"
      v-bind:index="index"
      v-bind:key="item.id"
    >{{item.attributes.description}} at {{item.attributes.happened_at | moment("DD-MM-YYYY HH:MM")}}</a-timeline-item>
  </a-timeline>
</template>
<script>
import Vue from "vue";
import { Timeline } from "ant-design-vue";
import VueResource from "vue-resource";
import moment from "moment";

Vue.http.headers.common["X-CSRF-Token"] = Rails.csrfToken();

Vue.use(Timeline);

let resource = Vue.resource("activities");

export default {
  data() {
    return {
      timelineItems: {},
      moment
    };
  },
  mounted() {
    this.fetchTimelines();
  },
  methods: {
    fetchTimelines() {
      resource.get().then(
        response => {
          this.timelineItems = response.body.data;
        },
        response => {
          console.error(response);
        }
      );
    }
  }
};
</script>
