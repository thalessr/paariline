import Vue from 'vue'
import Router from 'vue-router'
import Users from '../users.vue'
import Welcome from '../welcome.vue'
import Profiles from '../profiles.vue'
import MostRated from '../mostRated.vue'
import ChatRoom from '../chatRoom.vue'

Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/users',
            name: 'Users',
            component: Users
        },
        {
            path: '/',
            name: 'Home',
            component: Welcome
        },
        {
            path: '/profiles',
            name: 'Profiles',
            component: Profiles
        },
        {
            path: '/mostRatedPictures',
            name: 'MostRated',
            component: MostRated
        },
        {
            path: '/chatRoom',
            name: 'ChatRoom',
            component: ChatRoom
        }
    ]
})