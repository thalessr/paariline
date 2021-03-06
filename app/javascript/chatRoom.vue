<template>
  <div style="width: 100%;">
    <a-list itemLayout="horizontal" :dataSource="chatRooms">
      <a-list-item slot="renderItem" slot-scope="item, index">
        <a-collapse v-model="activeKey" @change="changeActivekey" accordion>
          <a-collapse-panel :header="item.attributes.name" :key="item.id" style="width: 700px">
            <a-list
              v-if="comments.length"
              :dataSource="comments"
              :header="`${comments.length} ${comments.length > 1 ? 'replies' : 'reply'}`"
              itemLayout="horizontal"
            >
              <a-list-item slot="renderItem" slot-scope="comment, index">
                <a-comment
                  :author="comment.attributes.sent_by_full_name"
                  :content="comment.attributes.content"
                >
                  <span slot="datetime">{{comment.attributes.sent_at | moment("DD-MM-YYYY HH:MM")}}</span>
                </a-comment>
              </a-list-item>
            </a-list>
            <a-comment>
              <a-avatar
                slot="avatar"
                src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png"
                alt="Han Solo"
              />
              <div slot="content">
                <a-form-item>
                  <a-textarea :rows="4" @change="handleChange" :value="value"></a-textarea>
                </a-form-item>
                <a-form-item>
                  <a-button
                    htmlType="submit"
                    :loading="submitting"
                    @click="handleSubmit"
                    type="primary"
                  >Add Comment</a-button>
                </a-form-item>
              </div>
            </a-comment>
          </a-collapse-panel>
        </a-collapse>
      </a-list-item>
    </a-list>
  </div>
</template>


<script>
import Vue from "vue";
import { List, Avatar, Collapse, Comment } from "ant-design-vue";
import VueResource from "vue-resource";
import ActionCable from "actioncable";
import moment from "moment";

Vue.use(List);
Vue.use(Avatar);
Vue.use(Collapse);
Vue.use(Comment);
Vue.use(VueResource);

let resource = Vue.resource("chat_rooms{/id}");
let messageResource = Vue.resource("chat_messages{/id}");
let cable = ActionCable.createConsumer("ws://localhost:3000/cable");

export default {
  name: "ChatRoom",
  data() {
    return {
      chatRooms: {},
      activeKey: ["-1"],
      comments: [],
      submitting: false,
      value: "",
      moment
    };
  },

  mounted() {
    Vue.http.headers.common["X-CSRF-Token"] = Rails.csrfToken();
    this.fecthChatRooms();
  },
  methods: {
    fecthChatRooms() {
      resource.get().then(
        response => {
          this.chatRooms = response.body.data;
        },
        response => {
          console.error(response);
        }
      );
    },
    fecthChatMessages(roomName) {
      this.comments = [];
      messageResource.get({ room_name: roomName }).then(
        response => {
          this.comments = response.body.data;
        },
        response => {
          console.error(response);
        }
      );
    },
    changeActivekey(key) {
      let chatRoom = this.chatRooms.find(room => room.id === key);
      if (chatRoom) {
        this.activeKey = [key];
        let chatRoomName = chatRoom.attributes.name;
        this.subscribeChannel(chatRoomName);
        this.fecthChatMessages(chatRoomName);
      }
    },
    subscribeChannel(roomName) {
      App.chatChannel = cable.subscriptions.create(
        {
          channel: "ChatRoomChannel",
          room: roomName
        },
        {
          received: chatMessage => {
            console.log(chatMessage);
            setTimeout(() => {
              this.comments = [...this.comments, JSON.parse(chatMessage).data];
            }, 1000);
          }
        }
      );
    },
    handleSubmit() {
      if (!this.value) {
        return;
      }

      this.submitting = true;

      App.chatChannel.send({ content: this.value });

      setTimeout(() => {
        this.submitting = false;
        this.value = "";
      }, 1000);
    },
    handleChange(e) {
      this.value = e.target.value;
    }
  }
};
</script>