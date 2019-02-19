
import Vue from 'vue'
import { Layout, message } from 'ant-design-vue';
import Dashboard from '../dashboard.vue'
import router from '../router';
import { Menu, Icon } from 'ant-design-vue';


document.addEventListener('DOMContentLoaded', () => {

    Vue.config.productionTip = false
    Vue.prototype.$message = message
    Vue.use(Layout);
    Vue.use(Menu);
    Vue.use(Icon);

    /* eslint-disable no-new */
    new Vue({
        el: '#dashboard',
        router,
        render: h => h(Dashboard)
    })
})