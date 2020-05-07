Feature: File Controller Actions

  Background: Set authentication and create project

    Given I set authentication token using "admin" account

    * I send a POST request to "/project/new/user/{admin.id}" with the following parameters
      | Language     | python    |
      | Project Name | PythonPro |

    * I save the "projectId" of project value
    * I save response as "P"

    * I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |

    * I save the "fileId" of project value
    * I save response as "F"

  @deleteFile @deleteProject
  Scenario: Get a file created

    When I send a GET request to "/file/{F.fileId}"
    Then I validate the response has status code 200
    And I validate the response body should match with "file/fileSchema.json" JSON schema

    And I validate the response contains the following data
      | name             | MainClass |
      | project.language | PYTHON_32 |
