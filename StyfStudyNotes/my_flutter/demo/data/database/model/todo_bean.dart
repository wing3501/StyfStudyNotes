class TodoBean {
  //todo数据库数据模型
 final int todoId; //id
 final String todoTitle; //标题
 final String todoContent; //内容
 final int todoCreateTime; //创建时间 存储为 时间戳
 final int todoStartTime; //开始做时间 存储为时间戳
 final int todoEndTime; //预计完成时间 存储为时间戳
 final String todoColor; //颜色 存储为 0xFFFF0000 格式
 final int todoDone; //是否完成  存储为 1为true,0为false
 final int todoIcon; //图标索引  存储为数字

  TodoBean({
    this.todoId, this.todoTitle, this.todoContent,
    this.todoCreateTime, this.todoEndTime, this.todoStartTime,
    this.todoColor = "0xFFFF0000",
    this.todoDone = 0,
    this.todoIcon = 0
  });
}