
import Vue from 'vue'
import { Layout, message, Dropdown, Menu, Icon, Breadcrumb } from 'ant-design-vue';
import Dashboard from '../dashboard.vue'
import router from '../router';

document.addEventListener('DOMContentLoaded', () => {

    Vue.config.productionTip = false
    Vue.prototype.$message = message
    Vue.use(Layout);
    Vue.use(Menu);
    Vue.use(Icon);
    Vue.use(Dropdown);
    Vue.use(Breadcrumb);

    /* eslint-disable no-new */
    new Vue({
        el: '#dashboard',
        router,
        render: h => h(Dashboard)
    })
})