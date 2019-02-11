
import Vue from 'vue'
import { Menu, Icon } from 'ant-design-vue';
import Dashboard from '../dashboard.vue'
import router from '../router';

document.addEventListener('DOMContentLoaded', () => {

    Vue.config.productionTip = false

    /* eslint-disable no-new */
    new Vue({
        el: '#dashboard',
        router,
        render:  h => h(Dashboard)
    })
})