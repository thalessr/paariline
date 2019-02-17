
import Vue from 'vue'
import { Layout } from 'ant-design-vue';
import Dashboard from '../dashboard.vue'
import router from '../router';
import ActionCableVue from 'actioncable-vue';

document.addEventListener('DOMContentLoaded', () => {

    Vue.config.productionTip = false
    Vue.use(Layout)
    Vue.use(ActionCableVue, {
        debug: true,
        debugLevel: 'error',
        connectionUrl: 'ws://localhost:3000/cable'
    });

    /* eslint-disable no-new */
    new Vue({
        el: '#dashboard',
        router,
        render: h => h(Dashboard)
    })
})