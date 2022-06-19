const String payLoadStructure = '''{
    "info": {
        "title": "Class Test For 9th",
        "documentTitle": "Class Test"
    },
    "form_body": {
        "includeFormInResponse": true,
        "requests": [
            {
                "updateSettings": {
                    "updateMask": "*",
                    "settings": {
                        "quizSettings": {
                            "isQuiz": true
                        }
                    }
                }
            }
        ]
    }
} ''';

const String multipleChoiceQuestion = ''' {
                "createItem": {
                    "location": {
                        "index": 0
                    },
                    "item": {
                        "title": "Who is prime minister of India ?",
                        "questionItem": {
                            "question": {
                                "required": true,
                                "choiceQuestion": {
                                    "type": "RADIO",
                                    "options": [
                                        {
                                            "value": "Jawaharlal Nehru"
                                        },
                                        {
                                            "value": "Narendra Modi"
                                        },
                                        {
                                            "value": "Indira Gandhi"
                                        },
                                        {
                                            "value": "Manmohan Singh"
                                        }
                                    ]
                                },
                                "grading": {
                                    "pointValue": 2,
                                    "correctAnswers": {
                                        "answers": [
                                            {
                                                "value": "Narendra Modi"
                                            }
                                        ]
                                    }
                                }
                            }
                        }
                    }
                }
            }''';

const paragraphQuestion = '''             {
                "createItem": {
                    "location": {
                        "index": 0
                    },
                    "item": {
                        "title": "Write a short note on Electric Vehicles.",
                        "questionItem": {
                            "question": {
                                "required": true,
                                "textQuestion": {
                                    "paragraph": true
                                },
                                "grading": {
                                    "pointValue": 5
                                }
                            }
                        }
                    }
                }
            }''';
