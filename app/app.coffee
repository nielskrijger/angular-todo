angular.module 'todoApp', ['ui.router', 'ngResource']
  .config ($stateProvider, $urlRouterProvider) ->

    $stateProvider.state 'todos',
      url: '/todos'
      templateUrl: 'templates/todos.html'
      controller: 'TodoController'

    .state 'todos-edit',
      url: '/todos/:todoIndex'
      templateUrl: 'templates/todo-edit.html'
      controller: 'TodoEditController'

    $urlRouterProvider.otherwise '/todos'
