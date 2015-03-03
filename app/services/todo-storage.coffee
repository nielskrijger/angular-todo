angular.module('todoApp').factory 'todoStorage', ($q, $resource) ->
  new class TodoStorage
    constructor: () ->
      console.log 'Init TodoStorage'
      @STORAGE_ID = 'angular-todo'
      @INITIAL_JSON = '/data/initial-todos.json'
      @todos = []
      @getAll()

    _getFromLocalStorage: () ->
      deferred = $q.defer()
      if localStorage.getItem(@STORAGE_ID)?
        console.log 'Retrieving todos from localstorage'
        deferred.resolve(JSON.parse localStorage.getItem(@STORAGE_ID))
      else
        console.log 'Retrieving initial example todos from json'
        Todo = $resource @INITIAL_JSON
        Todo.query (todos) ->
          console.log 'RES', todos
          console.log 'Retrieved initial JSON, found ' + todos.length + ' records'
          deferred.resolve(todos)
      deferred.promise

    _saveToLocalStorage: (todos) ->
      localStorage.setItem(@STORAGE_ID, JSON.stringify(@todos))

    clearCompleted: () ->
      deferred = $q.defer()
      incompleteTodos = @todos.filter((todo) -> !todo.completed)
      angular.copy(incompleteTodos, @todos)
      @_saveToLocalStorage(@todos)
      deferred.resolve(@todos)
      deferred.promise

    clearAll: () ->
      deferred = $q.defer()
      localStorage.clear()
      deferred.resolve(@getAll())
      deferred.promise

    delete: (todo) ->
      deferred = $q.defer()
      @todos.splice(@todos.indexOf(todo), 1)
      @_saveToLocalStorage(@todos)
      deferred.resolve(@todos)
      deferred.promise

    getAll: () ->
      console.log 'Retrieving todos from local storage'
      deferred = $q.defer()
      @_getFromLocalStorage().then (storedTodos) =>
        angular.copy(storedTodos, @todos)
        deferred.resolve(@todos)
      deferred.promise

    insert: (todo) ->
      console.log 'Inserting todo'
      deferred = $q.defer()
      @todos.push(todo)
      @_saveToLocalStorage(@todos)
      deferred.resolve(@todos)
      deferred.promise

    put: (todo, index) ->
      deferred = $q.defer()
      @todos[index] = todo
      @_saveToLocalStorage(@todos)
      deferred.resolve(@todos)
      deferred.promise
