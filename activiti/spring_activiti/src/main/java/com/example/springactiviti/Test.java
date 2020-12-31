package com.example.springactiviti;

import org.activiti.engine.*;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;

import java.util.List;

public class Test {

    public static void main(String[] args) {
//        new Test().deploy();
        new Test().getAllTaskByAssignee("liyicheng");
//        new Test().completeTask();
    }

    /**
     * 部署流程
     */

    public void deploy() {
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        RepositoryService repositoryService = processEngine.getRepositoryService();
        //获取资源相对路径
        String bpmnPath = "p1.bpmn";
        Deployment deployment = repositoryService //获取流程定义和部署对象相关的Service
                .createDeployment()//创建部署对象
                .addClasspathResource(bpmnPath)//加载资源文件，一次只能加载一个文件
                .key("myProcess_1")
                .deploy();//完成部署
        System.out.println("部署ID：" + deployment.getId());//1
        System.out.println("部署 key：" + deployment.getKey());//1
        System.out.println("部署时间：" + deployment.getDeploymentTime());

    }

    public  void getAllDeployments() {
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        RepositoryService repositoryService = processEngine.getRepositoryService();
        DeploymentQuery mDeploymentQuery = repositoryService.createDeploymentQuery();
        List<Deployment> list = mDeploymentQuery.list();
        for (Deployment deployment : list) {
            System.out.printf("---->>>>>", deployment.getKey() + "\n");
        }
    }

    /**
     * 获取部署的流程
     */
    public  void getProcessDefinition() {
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        RepositoryService repositoryService = processEngine.getRepositoryService();
        ProcessDefinitionQuery mProcessDefinitionQuery = repositoryService.createProcessDefinitionQuery();
        List<ProcessDefinition> list = mProcessDefinitionQuery.list();
        for (ProcessDefinition processDefinition : list) {
            System.out.println("流程定义ID:"+processDefinition.getId());//流程定义的key+版本+随机生成数
            System.out.println("流程定义名称:"+processDefinition.getName());//对应HelloWorld.bpmn文件中的name属性值
            System.out.println("流程定义的key:"+processDefinition.getKey());//对应HelloWorld.bpmn文件中的id属性值
            System.out.println("流程定义的版本:"+processDefinition.getVersion());//当流程定义的key值相同的情况下，版本升级，默认从1开始
            System.out.println("资源名称bpmn文件:"+processDefinition.getResourceName());
            System.out.println("资源名称png文件:"+processDefinition.getDiagramResourceName());
            System.out.println("部署对象ID:"+processDefinition.getDeploymentId());
            System.out.println("################################");
        }
    }

    public static void startInstance() {
        //获取ProcessEngine对象   默认配置文件名称：activiti.cfg.xml  并且configuration的Bean实例ID为processEngineConfiguration
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //获取到RuntimeService对象
        RuntimeService runtimeService = processEngine.getRuntimeService();
        //创建流程实例
        ProcessInstance holiday = runtimeService.startProcessInstanceByKey("myProcess_1");//红字是流程图的key值

        //输出实例信息
        System.out.println("流程部署ID：" + holiday.getDeploymentId());
        System.out.println("流程实例ID：" + holiday.getId());
        System.out.println("活动ID：" + holiday.getActivityId());
    }

    public  void getAllTask() {
        //获取ProcessEngine对象   默认配置文件名称：activiti.cfg.xml  并且configuration的Bean实例ID为processEngineConfiguration
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //获取到RuntimeService对象
        TaskService taskService = processEngine.getTaskService();
        //创建流程实例
        TaskQuery taskQuery = taskService.createTaskQuery();
        for (Task task : taskQuery.list()) {
            System.out.println("任务的id :"+task.getId());
            System.out.println("任务的key :"+task.getFormKey());
            System.out.println("任务的name :"+task.getName());
            System.out.println("################################");
        }

    }

    public  void getAllTaskByAssignee(String assignee) {
        //获取ProcessEngine对象   默认配置文件名称：activiti.cfg.xml  并且configuration的Bean实例ID为processEngineConfiguration
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //获取到RuntimeService对象
        TaskService taskService = processEngine.getTaskService();
        TaskQuery taskQuery = taskService.createTaskQuery();
        taskQuery.taskAssignee(assignee);
        for (Task task : taskQuery.list()) {
            System.out.println("任务的id :"+task.getId());
            System.out.println("任务的key :"+task.getFormKey());
            System.out.println("任务的name :"+task.getName());
            System.out.println("任务的人 :"+task.getAssignee());
            System.out.println("################################");
        }
    }


    /**
     * 审批任务
     */
    public  void completeTask() {
        //获取ProcessEngine对象   默认配置文件名称：activiti.cfg.xml  并且configuration的Bean实例ID为processEngineConfiguration
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //获取到RuntimeService对象
        TaskService taskService = processEngine.getTaskService();
        TaskQuery taskQuery = taskService.createTaskQuery();
//        taskQuery.taskAssignee("robin");

        for (Task task : taskQuery.list()) {
            System.out.println("任务的id :"+task.getId());
            System.out.println("任务的key :"+task.getFormKey());
            System.out.println("任务的name :"+task.getName());
            System.out.println("任务的人 :"+task.getAssignee());
            System.out.println("################################");
        }
    }



}
