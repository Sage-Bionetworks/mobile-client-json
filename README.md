# mobile-client-json
Json Schema Draft 7 documentation for the JSON model objects used to build the iOS and Android Assessment Models.

## Example Survey

The following is an example survey. Each element in the survey is a `Node` where the root-level `Node` must 
also be a known `Assessment` type. The [AssessmentModel][1] library
has only one "type" key defined for an `Assessment`, but this key must be included in the JSON or the serialization 
will fail.

[1]: <https://github.com/Sage-Bionetworks/AssessmentModelKMM> "AssessmentModelKMM"

- Note: The terms "node" and "step" are used interchangably within this document and essentially mean 
the same thing. This is for historical reasons wherein assessments are designed to conform to both the 
language/syntax used by older frameworks (namely ResearchKit and ResearchStack) and the concept of a
node tree that is familiar to developers who did not have to work with those frameworks. For this same
reason, "assessments" are also referred to as "tasks" and "surveys". Sorry. - syoung 03/25/2022

```
{
  "type" : "assessment",
  "$schema" : "https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/AssessmentObject.json",
  "identifier" : "surveyA",
  "versionString" : "1.0.0",
  "estimatedMinutes" : 3,
  "copyright" : "Copyright © 2022 Sage Bionetworks. All rights reserved.",
  "title" : "Example Survey A",
  "detail" : "This is intended as an example of a survey with a list of questions. There are no sections and there are no additional instructions. In this survey, pause navigation is hidden for all nodes. For all questions, the skip button should say 'Skip me'. Default behavior is that buttons that make logical sense to be displayed are shown unless they are explicitly hidden.",
  "shouldHideActions" : [
    "pause"
  ],
  "actions" : {
    "skip" : {
      "buttonTitle" : "Skip me",
      "type" : "default"
    }
  },
  "steps" : [
    {
      "type" : "overview",
      "identifier" : "overview",
      "title" : "Example Survey A",
      "detail" : "You will be shown a series of example questions. This survey has no additional instructions."
    },
    {
      "type" : "choiceQuestion",
      "identifier" : "choiceQ1",
      "comment" : "Go to the question selected by the participant. If they skip the question then go directly to follow-up.",
      "title" : "Choose which question to answer",
      "surveyRules" : [
        {
          "skipToIdentifier" : "followupQ"
        },
        {
          "matchingAnswer" : 1,
          "skipToIdentifier" : "simpleQ1"
        },
        {
          "matchingAnswer" : 2,
          "skipToIdentifier" : "simpleQ2"
        },
        {
          "matchingAnswer" : 3,
          "skipToIdentifier" : "simpleQ3"
        },
        {
          "matchingAnswer" : 4,
          "skipToIdentifier" : "simpleQ4"
        }
      ],
      "baseType" : "integer",
      "singleChoice" : true,
      "choices" : [
        {
          "value" : 1,
          "text" : "Enter some text"
        },
        {
          "value" : 2,
          "text" : "Birth year"
        },
        {
          "value" : 3,
          "text" : "Likert Scale"
        },
        {
          "value" : 3,
          "text" : "Decimal Scale"
        }
      ]
    },
    {
      "type" : "simpleQuestion",
      "identifier" : "simpleQ1",
      "nextStepIdentifier" : "followupQ",
      "title" : "Enter some text",
      "inputItem" : {
        "type" : "string",
        "placeholder" : "I like cake"
      }
    },
    {
      "type" : "simpleQuestion",
      "identifier" : "simpleQ2",
      "nextStepIdentifier" : "followupQ",
      "title" : "Enter a birth year",
      "inputItem" : {
        "type" : "year",
        "placeholder" : "1948",
        "formatOptions" : {
          "allowFuture" : false,
          "minimumYear" : 1900
        }
      }
    },
    {
      "type" : "simpleQuestion",
      "identifier" : "simpleQ3",
      "nextStepIdentifier" : "followupQ",
      "title" : "How much do you like apples on a scale of 1 to 5?",
      "uiHint" : "likert",
      "inputItem" : {
        "type" : "integer",
        "formatOptions" : {
          "maximumLabel" : "Very much",
          "maximumValue" : 5,
          "minimumLabel" : "Not at all",
          "minimumValue" : 1
        }
      }
    },
    {
      "type" : "simpleQuestion",
      "identifier" : "simpleQ4",
      "nextStepIdentifier" : "followupQ",
      "title" : "How much do you like apples as a number between 0 and 1?",
      "uiHint" : "slider",
      "inputItem" : {
        "type" : "number",
        "formatOptions" : {
          "maximumLabel" : "Very much",
          "maximumValue" : 1,
          "minimumLabel" : "Not at all",
          "minimumValue" : 0
        }
      }
    },
    {
      "type" : "choiceQuestion",
      "identifier" : "followupQ",
      "comment" : "If the participant selects 'No' then go to 'choiceQ1'",
      "title" : "Are you happy with your choice?",
      "surveyRules" : [
        {
          "matchingAnswer" : false,
          "skipToIdentifier" : "choiceQ1"
        }
      ],
      "baseType" : "boolean",
      "singleChoice" : true,
      "choices" : [
        {
          "value" : true,
          "text" : "Yes"
        },
        {
          "value" : false,
          "text" : "No"
        }
      ]
    },
    {
      "type" : "choiceQuestion",
      "identifier" : "multipleChoice",
      "title" : "What are your favorite colors?",
      "detail" : "Choose all that apply",
      "baseType" : "string",
      "singleChoice" : false,
      "choices" : [
        {
          "value" : "blue",
          "text" : "blue"
        },
        {
          "value" : "red",
          "text" : "red"
        },
        {
          "value" : "green",
          "text" : "green"
        },
        {
          "value" : "yellow",
          "text" : "yellow"
        },
        {
          "text" : "All of the above",
          "selectorType" : "all"
        },
        {
          "text" : "I don't have any",
          "selectorType" : "exclusive"
        }
      ],
      "other" : {
        "type" : "string"
      }
    },
    {
      "type" : "choiceQuestion",
      "identifier" : "favoriteFood",
      "title" : "What are you having for dinner?",
      "surveyRules" : [
        {
          "matchingAnswer" : "pizza",
          "skipToIdentifier" : "completion",
          "ruleOperator" : "ne"
        }
      ],
      "baseType" : "string",
      "singleChoice" : true,
      "choices" : [
        {
          "value" : "pizza",
          "text" : "pizza"
        },
        {
          "value" : "sushi",
          "text" : "sushi"
        },
        {
          "value" : "ice cream",
          "text" : "ice cream"
        }
      ],
      "other" : {
        "type" : "string"
      }
    },
    {
      "type" : "instruction",
      "identifier" : "pizza",
      "title" : "Mmmmm, pizza..."
    },
    {
      "type" : "completion",
      "identifier" : "completion",
      "title" : "You're done!"
    }
  ]
}
```

## Assessment and Section Nodes {#node-containers}

At the root level, the "type" should always be an object that conforms the the `Assessment` interface.
A section (ie. branch) node can be used to logically subgroup a collection of child nodes. Typically,
surveys do not use branching navigation logic. Both sections and assessments require a list of child
nodes, called "steps", that are shown in sequential order to the participant.

## Shared Node Keys

### Required Keys

All nodes, including the root-level `Assessment` are required to have a "type" and "identifier" key. 
The "type" keys supported by the [AssessmentModel][1] library are:

- [Node Containers](#node-containers)  
    - "assessment" : Root level assessment object.
    - "section" : A section (or branch) in the node tree.
- [Instruction Steps](#instruction-steps)
    - "overview" : Typically, this is the first screen shown to the participant as an overview of the assessment.
    - "instruction" : An instruction step includes additional information or instructions for the participant.
    - "completion" : Typically, this is the last step in the assessment and is displayed upon completion.
    - "permission" : This is a special step used to describe a permission required by the assessment.
- [Question Steps](#question-steps)
    - "simpleQuestion" : A single input field that *can* be entered as text.
    - "choiceQuestion" : A question where the participant is asked to select from a list of questions.

### Content Information Keys

All nodes may have a title, subtitle, detail, or image. 

### Button Action Keys

A `ButtonType` is an extensible string enum where the assessment designer associates a give
key name with either a requirement to hide the button by including it in the list of "shouldHideActions"
strings or modify the default text or icon for the button by including a mapping in the "actions"
dictionary. The `ButtonType` keys supported by the [AssessmentModel][1] library are:

- "goForward" : Navigate to the next step.
- "goBackward" : Navigate to the previous step.
- "skip" : Skip the step and immediately go forward.
- "cancel" : Exit the assessment.
- "pause" : Pause the assessment. Depending upon the assessment/step, this button may be associated with an action sheet or just pause a timer.
- "reviewInstructions" : Go back in the assessment and show previously displayed instructions.

For any given step, whether or not there is a button that logically appears, depends upon
the values in the "actions" dictionary and "shouldHideActions" list. Button behavior can be
set at any level of the node tree. For example the "goBackward" button could be hidden for
the entire survey or only hidden for a single node.

### Next Step Identifier

Any node may require navigation from that node to another node that is not the next node in the 
sequential list of "steps" for that node container. This is done using the "nextStepIdentifier"
key on that node. The value of that key should be either (a) a reserved keyword or (b) the identifier
for the node to jump to.

#### Reserved keywords:
- "exit" : Used to indicate that navigation should exit the assessment.
- "nextSection" : Used to indicate that navigation should continue directly to the next section. This is only applicable when called from within a section node.

## Instruction Steps {#instruction-steps}

Instruction steps are nodes that show instructions to the participant in some manner. These
nodes may include spoken instructions or are flagged a `true` value for the "fullInstructionsOnly"
to indicate that after the first time showing the assessment, the instructions should be displayed
if and only if the participant wants to review them.

## Question Steps {#question-steps}

Question steps ask a question. While Sage Bionetworks mobile developers have in the past supported
many different designs for many different kinds of questions, we are attempting to limit these within
the [AssessmentModel][1] library to the most commonly required types. 

Currently questions can be:
- [Simple Questions](#simple-questions)
- [Choice Questions](#choice-questions)

### Survey Rules

All questions have "surveyRules" which are used to define navigation in response to the answer
to the given question. These elements have the following keys:

- "skipToIdentifier" : The node identifier or reserved keyword to skip to if the rule evaluates to `true`.
- "matchingAnswer" : A value to compare against.
- "ruleOperator" : A string enum defining the operator for the rule.
    - "eq" : `answer == matchingAnswer`
    - "ne" : `answer != matchingAnswer`
    - "lt" : `answer < matchingAnswer`
    - "gt" : `answer > matchingAnswer`
    - "le" : `answer <= matchingAnswer`
    - "ge" : `answer >= matchingAnswer`

### UI Hint

The "uiHint" key can be used to give a hint as to how the UI/UX designer wants to display the question.
Within the [AssessmentModel][1] library, the following hints are currently recognized:

- Choice Questions: "checkbox", "radioButton"
- Number Questions: "textfield", "slider", "likert"
- Text Questions: "textfield", "multipleLine"

### Simple Questions {#simple-questions}

```
    {
      "type" : "simpleQuestion",
      "identifier" : "simpleQ1",
      "title" : "Enter some text",
      "inputItem" : {
        "type" : "string",
      }
    }
```

A simple question has a single answer that can be converted to/from a text field based on the values
defined by the [TextInputItem] (#text-entry).

### Text Input Item {#text-entry}

A text entry input defines the primitive json type of an answer ("string", "integer", "number") as well as
any validation and formatting required to convert the entered text to/from an answer value. This can include
a regular expression, number range, date limits, human biometric, etc. depending upon the type of the object.

- See Also: [TextInputItem](/schemas/v2/TextInputItem.json)

### Choice Questions {#choice-questions}

```
      "type" : "choiceQuestion",
      "identifier" : "multipleChoice",
      "title" : "What are your favorite colors?",
      "detail" : "Choose all that apply",
      "baseType" : "string",
      "singleChoice" : false,
      "choices" : [
        {"value" : "blue", "text" : "blue"},
        {"value" : "red", "text" : "red"},
        {"value" : "green", "text" : "green"},
        {
          "text" : "All of the above",
          "selectorType" : "all"
        },
        {
          "text" : "I don't have any",
          "selectorType" : "exclusive"
        }
      ],
      "other" : {
        "type" : "string"
      }
```

Choice questions are either "singleChoice" or multiple choice. They are required to have a "baseType" which
is any valid json primitive ("string", "integer", "number", "boolean") and they are required to have a list
of "choices". The "other" field is a text field where the validation requirements are decoded as a 
[TextInputItem] (#text-entry).

The choice "value" is the answer to return for that selection. This value should be either `null` or the 
same base type as defined by the "baseType" key. The choice "text" is the localized string to display to
the participant. The "selectorType" is an enum ("default", "all", "exclusive") that can be used to indicate
special selection handling where "exclusive" should deselect all other choices and "all" should select all
non-exclusive choices. For a multiple choice question, the answer will be an array of the selected choices.
If the only selected value does not have an associated "value", then the array will be empty.
