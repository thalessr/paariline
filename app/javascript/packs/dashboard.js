
import Vue from 'vue'
import { Layout } from 'ant-design-vue';
import Dashboard from '../dashboard.vue'
import router from '../router';

document.addEventListener('DOMContentLoaded', () => {

    Vue.config.productionTip = false
    Vue.use(Layout)

    /* eslint-disable no-new */
    new Vue({
        el: '#dashboard',
        router,
        render: h => h(Dashboard)
    })
})