import Vue from 'vue'
import { Form, Icon, Button, Input } from 'ant-design-vue';
import Users from '../users.vue'
import VueResource from 'vue-resource'

document.addEventListener('DOMContentLoaded', () => {
    Vue.use(Form);
    Vue.use(Icon);
    Vue.use(Button);
    Vue.use(Input);
    Vue.use(VueResource);
    Vue.config.productionTip = false;
    Vue.http.headers.common['X-CSRF-Token'] = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute('content')
    const app = new Vue({
        el: '#users',
        render: h => h(Users)
    })
})