<template>
  <div>
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
        <div class="clearfix">
          <a-upload :fileList="fileList" :remove="handleRemove" :beforeUpload="beforeUpload">
            <a-button>
              <a-icon type="upload"/>Select File
            </a-button>
          </a-upload>
        </div>
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
  InputNumber,
  Upload,
  Modal
} from "ant-design-vue";
import VueResource from "vue-resource";
import VueMoment from "vue-moment";
// import { DirectUpload } from "@rails/activestorage";

Vue.use(Form);
Vue.use(Icon);
Vue.use(Button);
Vue.use(Input);
Vue.use(DatePicker);
Vue.use(InputNumber);
Vue.use(Upload);
Vue.use(Modal);
Vue.use(VueResource);
Vue.use(VueMoment);

function hasErrors(fieldsError) {
  return Object.keys(fieldsError).some(field => fieldsError[field]);
}

Vue.http.headers.common["X-CSRF-Token"] = Rails.csrfToken();
var resource = Vue.resource("users{/id}");

export default {
  data() {
    return {
      hasErrors,
      form: this.$form.createForm(this),
      user: { new_pictures: [] },
      visible: false,
      type: "success",
      message: "",
      description: "",
      fileList: []
    };
  },
  mounted() {
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
          this.$message.success("User saved sucessfully");
          this.user = response.body.data.attributes;
          this.user.birth_date = this.$moment(this.user.birth_date);
        },
        response => {
          let errorMessage = "";
          response.body.errors.forEach(function(element) {
            errorMessage += `${element} `;
          });
          this.$message.error(errorMessage);
        }
      );
    },
    handleRemove(file) {
      const index = this.fileList.indexOf(file);
      const newFileList = this.fileList.slice();
      newFileList.splice(index, 1);
      this.fileList = newFileList;
    },
    beforeUpload(file) {
      this.fileList = [...this.fileList, file];
      this.user.new_pictures = this.fileList;
      return false;
    },
    fileUpload() {
      // const upload = new DirectUpload(file, url);
    }
  }
};
</script>