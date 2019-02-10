
import Vue from 'vue'
import { Menu, Icon } from 'ant-design-vue';
import Dashboard from '../dashboard.vue'

document.addEventListener('DOMContentLoaded', () => {
    Vue.use(Menu);
    Vue.use(Icon);
    Vue.config.productionTip = false;
    const app = new Vue({
        el: '#dashboard',
        render: h => h(Dashboard)
    })
})