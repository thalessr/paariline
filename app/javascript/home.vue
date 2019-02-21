<template>
  <div>Tere tulemast!</div>
</template>
<script>
import Vue from "vue";
import { Icon } from "ant-design-vue";

Vue.http.headers.common["X-CSRF-Token"] = Rails.csrfToken();

Vue.use(Icon);


export default {
  data() {
    return {};
  },
  mounted() {},
  methods: {}
};
</script>
