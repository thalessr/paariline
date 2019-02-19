<template>
  <a-form layout="inline" :form="form" @submit="handleSubmit">
    <a-form-item>
      <a-input placeholder="Email" v-model="user.email">
        <a-icon slot="prefix" type="user" style="color:rgba(0,0,0,.25)"/>
      </a-input>
    </a-form-item>
    <a-form-item>
      <a-input type="password" placeholder="Password" v-model="user.password">
        <a-icon slot="prefix" type="lock" style="color:rgba(0,0,0,.25)"/>
      </a-input>
    </a-form-item>
    <a-form-item>
      <a-button type="primary" html-type="submit">Log in</a-button>
    </a-form-item>
  </a-form>
</template>

<script>
import Vue from "vue";
import VueResource from "vue-resource";

Vue.use(VueResource);

Vue.http.headers.common["X-CSRF-Token"] = document
  .querySelector('meta[name="csrf-token"]')
  .getAttribute("content");

let resource = Vue.resource("/users/sign_in");
export default {
  data() {
    return {
      form: this.$form.createForm(this),
      user: {}
    };
  },
  mounted() {},
  methods: {
    handleSubmit(e) {
      e.preventDefault();
      resource.save({}, { user: this.user }).then(
        response => {
          this.$router.go(-1);
        },
        response => {
          this.$message.error("Wrong email or password");
        }
      );
    }
  }
};
</script>