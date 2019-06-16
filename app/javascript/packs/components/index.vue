<template>
  <div>
    <!-- 新規作成部分 -->
    <div class="row">
      <div class="col s10 m11">
        <input v-model="newPost" id="new-post-form" class="form-control" placeholder="Add your post!!">
      </div>
      <div class="col s2 m1">
        <div v-on:click="createPost" class="btn-floating waves-effect waves-light red">
          <i class="material-icons">add</i>
        </div>
      </div>
    </div>
    <!-- リスト表示部分 -->
    <div>
      <ul class="collection">
        <li v-for="post in posts" v-if="post.is_display" v-bind:id="'row_post_' + post.id" class="collection-item">
          <label>
            <input type="checkbox" class="filled-in" v-on:change="donePost(post.id)" v-bind:id="'post_' + post.id" />
            <span v-bind:for="'post_' + post.id">{{ post.title }}</span>
          </label>
       </li>
      </ul>
    </div>
    <!-- 完了済みタスク表示ボタン -->
    <div class="btn" v-on:click="displayFinishedPosts">Display finished posts</div>
    <!-- 完了済みタスク一覧 -->
    <div id="finished-posts" class="display_none">
      <ul class="collection">
        <li v-for="post in posts" v-if="!post.is_display" v-bind:id="'row_post_' + post.id" class="collection-item">
          <label>
            <input type="checkbox" class="filled-in" v-bind:id="'post_' + post.id" checked="checked" disabled="disabled" />
            <span v-bind:for="'post_' + post.id"  class="line-through">{{ post.title }}</span>
          </label>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function () {
      return {
        posts: [],
        newPost: ''
      }
    },
    mounted: function () {
      this.fetchPosts();
    },
    methods: {
      fetchPosts: function () {
        axios.get('/api/posts').then((response) => {
          for(var i = 0; i < response.data.posts.length; i++) {
            this.posts.push(response.data.posts[i]);
          }
        }, (error) => {
          console.log(error);
        });
      },
      displayFinishedPosts: function() {
        document.querySelector('#finished-posts').classList.toggle('display_none');
      },
      createPost: function () {
        if (!this.newPost) return console.log("ng");
        axios.post('/api/posts', { post: { title: this.newPost, firstContent: this.newPost } }).then((response) => {
          this.posts.unshift(response.data.post);
          this.newPost = '';
        }, (error) => {
          console.log(error);
        });
      },
      donePost: function (post_id) {
        axios.put('/api/posts/' + post_id, { post: { is_display: false } }).then((response) => {
          this.moveFinishedPost(post_id);
        }, (error) => {
          console.log(error);
        });
      },
      moveFinishedPost: function(post_id) {
        var el = document.querySelector('#row_post_' + post_id);
        // DOMをクローンしておく
        var el_clone = el.cloneNode(true);
        // 未完了の方を先に非表示にする
        el.classList.add('display_none');
        // もろもろスタイルなどをたして完了済みに追加
        el_clone.getElementsByTagName('input')[0].checked = 'checked';
        el_clone.getElementsByTagName('input')[0].disabled = 'disabled';
        el_clone.getElementsByTagName('span')[0].classList.add('line-through');
        el_clone.getElementsByTagName('span')[0].classList.remove('word-color-black');
        var li = document.querySelector('#finished-posts > ul > li:first-child');
        document.querySelector('#finished-posts > ul').insertBefore(el_clone, li);
      }
    }
  }
</script>

<style scoped>
 [v-cloak] {
   display: none;
 }
 .display_none {
   display:none;
 }
 .line-through {
   text-decoration: line-through;
 }
</style>
