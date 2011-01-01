Feature: Examining files
  In order to test a running system
  As an administrator
  I want to examine files

  @steps
  Scenario: File exists
    Given we have an empty file named '/tmp/foo.file'
     Then a file named '/tmp/foo.file' should exist

  @steps
  Scenario: File does not exist
     Then a file named '/tmp/foo.filepants' should not exist

  @steps
  Scenario: Atime
    Given we have an empty file named '/tmp/foo.file'
      And we have the atime/mtime of '/tmp/foo.file'
      And I run 'sleep 1'
      And I run 'touch -a /tmp/foo.file'
     Then the atime of '/tmp/foo.file' should be different

  @steps
  Scenario: Mtime
    Given we have an empty file named '/tmp/foo.file'
      And we have the atime/mtime of '/tmp/foo.file'
      And I run 'sleep 1'
      And I run 'touch -m /tmp/foo.file'
     Then the mtime of '/tmp/foo.file' should be different

  @steps
  Scenario: File contents
    When I run 'shopt -s xpg_echo ; echo "monkeypants\nmonkeyshorts" > /tmp/monkeytest.file'
    Then a file named '/tmp/monkeytest.file' should contain 'monkeypants'

  @steps
  Scenario: File contents multiple times
    When I run 'shopt -s xpg_echo ; echo "monkeypants\nmonkeyshorts" > /tmp/monkeytest.file'
    Then a file named '/tmp/monkeytest.file' should contain 'monkey.+' only '2' times

  @steps
  Scenario: File modes
    When I run 'touch /tmp/filemode.file'
     And I run 'chmod 644 /tmp/filemode.file'
    Then the file named '/tmp/filemode.file' should have mode '644'
     And the file named '/tmp/filemode.file' should have mode '0644'

  @steps
  Scenario: Directory exists
    When I run 'mkdir -p /tmp/dirtest'
    Then a directory named '/tmp/dirtest' should exist

  @steps
  Scenario: Directory does not exist
    Then a directory named '/tmp/dirtest-m000' should not exist

  @steps
  Scenario: Directory mode
    When I run 'mkdir -p /tmp/dirtest'
     And I run 'chmod 755 /tmp/dirtest'
    Then the directory named '/tmp/dirtest' should have mode '755'
     And the directory named '/tmp/dirtest' should have mode '0755'


