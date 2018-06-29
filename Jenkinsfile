#!groovy

pipeline 
{
  agent none
  stages 
  {
    stage('Maven Install') 
    {
     /* agent 
      {
        docker 
        {
          image 'maven:3.5.0'
        }
      } */
      steps 
      {
        sh 'mvn clean install'
      }
    }
    stage('Docker Build') 
    {
      agent any
      steps 
      {
        sh 'docker build -t bathinapullarao/spring-petclinic:latest .'
       }
    }
    stage('Docker Push') 
    {
      agent any
      steps 
      {
        
        withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
          {
            sh "docker login -u $env.USERNAME -p $env.PASSWORD"
            sh "docker push bathinapullarao/spring-petclinic:latest"
            echo "Image push complete"
          }
      }
    }
 /* stage('Sonar')
    {
           try 
           {
            sh "mvn sonar:sonar"
            } 
	         catch(error)
	          {
            echo "The sonar server could not be reached ${error}"
            }
     }   */
 stage('unitTest')
	{
        try {
            sh "mvn test" 
	          } 
        catch(error)
	          {
            echo "The Maven can not perform Junit ${error}"
            }
   }
/*  
    
stage('approvalofQA')
	  {
    input "Deploy to QA?"
    	  }
    node {
	    slackSend (channel: "#jenkins_notification", color: '#4286f4', message: "Deploy Approval: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.JOB_DISPLAY_URL})")
                script {
                    try  {
                        timeout(time:30, unit:'MINUTES') 
			    {
                            env.APPROVE_QA = input message: 'Deploy to QA', ok: 'Continue',
                                parameters: [choice(name: 'APPROVE_QA', choices: 'YES\nNO', description: 'Deploy to QA environment?')]
                            if (env.APPROVE_QA == 'YES')
				    {
					    
			            stage('deploy to QA')
					    {
                                            dipQA(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, 8086)
                                            }
					    	    
                                env.DPROD = true
                            	    } else 
				    {
                                env.DPROD = false
			        echo "QA test Faild"
                                    }
                            }
                          } catch (error) 
			  {
                        env.DPROD = true
                        echo 'Timeout has been reached! Deploy to QA automatically activated'
                          }
                      }
	  }
    stage('approvalOfUAT'){
    input "Deploy to UAT?"
    }
    node {
	slackSend (channel: "#jenkins_notification", color: '#4286f4', message: "Deploy Approval: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.JOB_DISPLAY_URL})")
                script {
                    try  {
                        timeout(time:30, unit:'MINUTES') 
			    {
                            env.APPROVE_UAT = input message: 'Deploy to UAT', ok: 'Continue',
                                parameters: [choice(name: 'APPROVE_UAT', choices: 'YES\nNO', description: 'Deploy to UAT?')]
                            if (env.APPROVE_UAT == 'YES')
				    {
				    stage('deploy to UAT'){
        			    	dipUAT(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, 8087)
        						}
                                env.DPROD = true
                            	    } else 
				    {
                                env.DPROD = false
			        echo "UAT faild"
                            	    }
                            }
                    	  } catch (error) 
			{
                        env.DPROD = true
                        echo 'Timeout has been reached! Deploy to PRODUCTION automatically activated'
                    	}
		      }
	    
          }
    stage('approvalOfProd'){
    input "Deploy to Prod?"
    }
    node {
	    slackSend (channel: "#jenkins_notification", color: '#4286f4', message: "Deploy Approval: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.JOB_DISPLAY_URL})")
                script {
                    try  {
                        timeout(time:30, unit:'MINUTES') 
			    {
                            env.APPROVE_PROD = input message: 'Deploy to Production', ok: 'Continue',
                                parameters: [choice(name: 'APPROVE_PROD', choices: 'YES\nNO', description: 'Deploy from STAGING to PRODUCTION?')]
                            if (env.APPROVE_PROD == 'YES')
				    {
                                stage('deploy to Prod')
					    {
        				dipProd(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, 8088)
        				    }
					    env.DPROD = true
				    }
			             else 
				    {
                                env.DPROD = false
				echo "Rejected to Deploy by DEVOPS eng"
                            	    }
                             }
                    	   } catch (error) 
			   {
                        env.DPROD = true
                        echo 'Timeout has been reached! Deploy to PRODUCTION automatically activated'
                           }
		       }  
           }
  */  
  }
}
