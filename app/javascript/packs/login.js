/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'
import { Menu, Icon, Form, Input, Button, Row, Col, message } from 'ant-design-vue';
import Login from '../login.vue'
import router from '../router';

document.addEventListener('DOMContentLoaded', () => {
    Vue.use(Menu);
    Vue.use(Form);
    Vue.use(Input);
    Vue.use(Icon);
    Vue.use(Row);
    Vue.use(Col);
    Vue.use(Button);

    Vue.prototype.$message = message;

    Vue.config.productionTip = false;
    const app = new Vue({
        el: '#login',
        router,
        render: h => h(Login)
    })
})
