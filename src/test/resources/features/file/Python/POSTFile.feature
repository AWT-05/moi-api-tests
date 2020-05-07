Feature: File Controller Actions By POST

  Background: Set authentication and create a project

    Given I set authentication token using "normalUser" account

    * I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Language     | python    |
      | Project Name | PythonPro |

    * I save "projectId" value to clean project workspace
    * I save response as "P"


  @deleteFile @deleteProject
  Scenario: Create a Python File

    When I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |

    Then I validate the response has status code 200
    And I save "fileId" value to clean file workspace
    And I validate the response body should match with "file/fileSchema.json" JSON schema

    And I validate the response contains the following data
      | name             | MainClass |
      | project.language | PYTHON_32 |


  @deleteFile @deleteProject
  Scenario Outline: The file name cannot be just numbers or start with numbers

    When I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | <Name>                   |

    Then I validate the response has status code 400

    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

    Examples: Values for the field name
      | Name        |
      | 123         |
      | 8_          |
      | 0valid_name |


  @deleteFile @deleteProject
  Scenario Outline: The file name cannot have white spaces

    When I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | <Name>                   |

    Then I validate the response has status code 400

    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

    Examples: Values for the field name
      | Name        |
      | valid name  |
      | v_name 1    |
      | mainClass 0 |


  @deleteFile @deleteProject
  Scenario Outline: Creation without some required field

    When I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | <Field> | <Values> |

    Then I validate the response has status code 400

    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

    Examples: Required fields for a file
      | Field     | Values                   |
      | File Name | without_code             |
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
