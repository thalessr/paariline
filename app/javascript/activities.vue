<template>
  <a-timeline mode="alternate">
    <a-timeline-item
      v-for="(item, index) in timelineItems"
      v-bind:item="item"
      v-bind:index="index"
      v-bind:key="item.id"
    >
      {{item.attributes.description}} at {{item.attributes.happened_at | moment("DD-MM-YYYY HH:MM")}}
      <a-icon
        slot="dot"
        type="clock-circle-o"
        style="font-size: 20px;"
        v-if="index == timelineItems.length - 1"
      />
      <a-icon
        slot="dot"
        theme="twoTone"
        :twoToneColor="item.attributes.color || blue"
        :type="item.attributes.icon"
        style="font-size: 20px;"
        v-if="item.attributes.icon"
      />
    </a-timeline-item>
  </a-timeline>
</template>
<script>
import Vue from "vue";
import { Timeline, Icon } from "ant-design-vue";
import VueResource from "vue-resource";
import moment from "moment";

Vue.use(Timeline);
Vue.use(Icon);

let resource = Vue.resource("activities");

export default {
  data() {
    return {
      timelineItems: {},
      moment
    };
  },
  mounted() {
    Vue.http.headers.common["X-CSRF-Token"] = Rails.csrfToken();
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
