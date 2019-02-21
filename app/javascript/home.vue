<template>
  <div>Tere tulemast!</div>
</template>
<script>
import Vue from "vue";
import { Icon } from "ant-design-vue";

Vue.use(Icon);

export default {
  data() {
    return {};
  },
  mounted() {
    Vue.http.headers.common["X-CSRF-Token"] = Rails.csrfToken();
  },
  methods: {}
};
</script>
