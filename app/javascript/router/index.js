import Vue from 'vue'
import Router from 'vue-router'
import Users from '../users.vue'
import Welcome from '../welcome.vue'
import { Menu, Icon } from 'ant-design-vue';

Vue.use(Router)
Vue.use(Menu);
Vue.use(Icon);

export default new Router({
    routes: [
        {
            path: '/',
            name: 'Hello',
            component: Users
        },
        {
            path: '/about',
            name: 'About',
            component: Welcome
        },
        {
            path: '/coins/:id',
            name: 'Coins',
            component: Users
        }
    ]
})