import consumer from "./consumer"

document.addEventListener('turbolinks:load',()=>{
  const posts = document.querySelector("#posts")
  const scrollToBottom = () => {
      posts.scrollTop = posts.scrollHeight;
    };
  const appRoom = consumer.subscriptions.create({channel: "ChatChannel", group_id: posts.dataset.group_id}, {
    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      return [posts.insertAdjacentHTML('beforeend',data.message), scrollToBottom()];
    },
  
    speak: function(message) {
      return this.perform('speak');
    }
  })
  
  const postBtn = document.querySelector('#post-btn');
  const postContent = document.querySelector('#post-content');
  postBtn.addEventListener("click", function() {
      appRoom.speak(postContent.value);
  })
  postBtn.addEventListener("touchend", function() {
      appRoom.speak(postContent.value);
  })
  
})

  

