<template>
  <div>
    <a-alert
      v-if="visible"
      :message="message"
      :description="description"
      :type="type"
      showIcon
      closable
    />

    <a-form layout="vertical" :form="form" @submit="handleSubmit">
      <a-form-item>
        <a-input v-model="user.first_name" placeholder="First Name"/>
      </a-form-item>
      <a-form-item>
        <a-input v-model="user.last_name" placeholder="Last Name"/>
      </a-form-item>
      <a-form-item>
        <a-input-number :min="13" :max="100" v-model="user.age" placeholder="Age"/>
      </a-form-item>
      <a-form-item>
        <a-input v-model="user.email" placeholder="Email"/>
      </a-form-item>
      <a-form-item>
        <a-input v-model="user.city" placeholder="City"/>
      </a-form-item>
      <a-form-item>
        <a-date-picker v-model="user.birth_date" placeholder="Birth Date" style="width: 100%"/>
      </a-form-item>
      <a-form-item>
        <a-button type="primary" html-type="submit">Edit</a-button>
      </a-form-item>
    </a-form>
  </div>
</template>

<script>
import Vue from "vue";
import {
  Form,
  Icon,
  Button,
  Input,
  DatePicker,
  Alert,
  InputNumber
} from "ant-design-vue";
import VueResource from "vue-resource";
import VueMoment from "vue-moment";

Vue.use(Form);
Vue.use(Icon);
Vue.use(Button);
Vue.use(Input);
Vue.use(DatePicker);
Vue.use(Alert);
Vue.use(InputNumber);
Vue.use(VueResource);
Vue.use(VueMoment);

Vue.http.headers.common["X-CSRF-Token"] = document
  .querySelector('meta[name="csrf-token"]')
  .getAttribute("content");
var resource = Vue.resource("users{/id}");

export default {
  data() {
    return {
      form: this.$form.createForm(this),
      user: {},
      visible: false,
      type: "success",
      message: "",
      description: ""
    };
  },
  mounted() {
    this.$nextTick(() => {
      this.form.validateFields();
    });
    this.$cable.subscribe(
      { channel: "ChatRoomChannel", room: "private" },
      "chat_channel_private"
    );
    this.fecthCurrentUser();
  },
  methods: {
    // Only show error after a field is touched.
    fecthCurrentUser() {
      this.$http.get("users/1").then(
        response => {
          this.user = response.body.data.attributes;
          this.user.birth_date = this.$moment(this.user.birth_date);
        },
        response => {
          console.error(response);
        }
      );
    },
    handleSubmit(e) {
      e.preventDefault();
      resource.update({ id: this.user.id }, { user: this.user }).then(
        response => {
          this.displayMessage("success", "Success", "User saved sucessfully");
          this.user = response.body.data.attributes;
          this.user.birth_date = this.$moment(this.user.birth_date);
        },
        response => {
          let errorMessage = "";
          response.body.errors.forEach(function(element) {
            errorMessage += `${element} `;
          });

          this.displayMessage("error", "Errors", errorMessage);
        }
      );
    },
    displayMessage(messageType, message, description) {
      this.type = messageType;
      this.message = message;
      this.visible = true;
      this.description = description;
    }
  }
};
</script>