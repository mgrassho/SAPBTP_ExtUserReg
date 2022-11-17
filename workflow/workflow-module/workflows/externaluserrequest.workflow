{
	"contents": {
		"2154dabf-9831-43ce-b8d5-a849e1fa3c94": {
			"classDefinition": "com.sap.bpm.wfs.Model",
			"id": "externaluserrequest",
			"subject": "externaluserrequest",
			"name": "externaluserrequest",
			"documentation": "",
			"lastIds": "62d7f4ed-4063-4c44-af8b-39050bd44926",
			"events": {
				"11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3": {
					"name": "StartEvent1"
				},
				"2798f4e7-bc42-4fad-a248-159095a2f40a": {
					"name": "EndEvent1"
				}
			},
			"activities": {
				"eb2df1c2-ec26-470c-88ba-02083ed64120": {
					"name": "Decision"
				},
				"7b69565e-3ff9-497d-9710-e8592be1212a": {
					"name": "DecisionPath"
				},
				"c37cfdf2-4d72-47a8-8c8a-303a4de1aad1": {
					"name": "EmailToRequester"
				},
				"7274d569-ada1-45fa-b930-28996dfe223f": {
					"name": "SendRejectionToBackend"
				},
				"31cedd0c-90d1-40a5-8ff8-121cc5947475": {
					"name": "Approval Email to Requestor"
				},
				"48ff3f19-f502-4acb-8dfa-7994218e4c02": {
					"name": "Reject Email to Requester"
				},
				"9a4b639e-154d-4294-94cc-6f9e243b4486": {
					"name": "SendApprovalToBackend"
				},
				"e7f7cbc8-b7a2-4417-b46d-2fc3d03a0c75": {
					"name": "PerpareConfirmationResponse"
				},
				"d75e103d-2b2c-4820-83f6-c01bd927f24c": {
					"name": "PrepareRejectionResponse"
				}
			},
			"sequenceFlows": {
				"766dec37-88d7-48ee-a57d-0cea2aaac22f": {
					"name": "NoApproved"
				},
				"b3d81247-177c-4065-9241-2fe909cdd24d": {
					"name": "SequenceFlow9"
				},
				"66ab16f4-1e30-42ae-bb19-e18c475e19fb": {
					"name": "Approved"
				},
				"a6310b0e-e6de-4a90-b8d4-2cb8607700e2": {
					"name": "SequenceFlow16"
				},
				"65e59ee0-a308-48c2-9ae9-011041cedae6": {
					"name": "SequenceFlow20"
				},
				"3c3eff36-4db3-4b68-8bf0-59df060dee99": {
					"name": "SequenceFlow22"
				},
				"eec50302-cf8c-42ba-8d44-b00ed41a99c7": {
					"name": "SequenceFlow24"
				},
				"cdf9ff46-c07a-4814-9cec-87d305c2af17": {
					"name": "SequenceFlow26"
				},
				"7e2d41d5-04f5-4f1e-b123-74572a8da8a6": {
					"name": "SequenceFlow27"
				},
				"8f53ee17-ba14-4d16-a98b-8bac7a109942": {
					"name": "SequenceFlow28"
				},
				"33c64cda-b327-4776-879d-ed4fb914c0e7": {
					"name": "SequenceFlow29"
				}
			},
			"diagrams": {
				"42fa7a2d-c526-4a02-b3ba-49b5168ba644": {}
			}
		},
		"11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3": {
			"classDefinition": "com.sap.bpm.wfs.StartEvent",
			"id": "startevent1",
			"name": "StartEvent1"
		},
		"2798f4e7-bc42-4fad-a248-159095a2f40a": {
			"classDefinition": "com.sap.bpm.wfs.EndEvent",
			"id": "endevent1",
			"name": "EndEvent1"
		},
		"eb2df1c2-ec26-470c-88ba-02083ed64120": {
			"classDefinition": "com.sap.bpm.wfs.UserTask",
			"subject": "Decide on new external user request",
			"priority": "MEDIUM",
			"isHiddenInLogForParticipant": false,
			"supportsForward": false,
			"userInterface": "sapui5://comsapbpmworkflow.comsapbpmwusformplayer/com.sap.bpm.wus.form.player",
			"recipientUsers": "martin.grasshoff@sap.com",
			"formReference": "/forms/externaluserrequest/UserRegistrationApprovalForm.form",
			"userInterfaceParams": [{
				"key": "formId",
				"value": "userregistrationapprovalform"
			}, {
				"key": "formRevision",
				"value": "1.0"
			}],
			"id": "usertask1",
			"name": "Decision"
		},
		"7b69565e-3ff9-497d-9710-e8592be1212a": {
			"classDefinition": "com.sap.bpm.wfs.ExclusiveGateway",
			"id": "exclusivegateway1",
			"name": "DecisionPath",
			"default": "766dec37-88d7-48ee-a57d-0cea2aaac22f"
		},
		"c37cfdf2-4d72-47a8-8c8a-303a4de1aad1": {
			"classDefinition": "com.sap.bpm.wfs.MailTask",
			"destinationSource": "consumer",
			"id": "mailtask2",
			"name": "EmailToRequester",
			"mailDefinitionRef": "baa010ae-6931-4323-8edd-e36780c52e12"
		},
		"7274d569-ada1-45fa-b930-28996dfe223f": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "ExtUserReg-app-srv",
			"destinationSource": "consumer",
			"path": "/manage-user-registrations/RegistrationRequest(${context.ID})",
			"httpMethod": "PATCH",
			"requestVariable": "${context.RejectionRequest}",
			"id": "servicetask1",
			"name": "SendRejectionToBackend"
		},
		"31cedd0c-90d1-40a5-8ff8-121cc5947475": {
			"classDefinition": "com.sap.bpm.wfs.MailTask",
			"destinationSource": "consumer",
			"id": "mailtask3",
			"name": "Approval Email to Requestor",
			"mailDefinitionRef": "3d49de5c-8391-4d4e-aaa4-dee0168f8b6e"
		},
		"48ff3f19-f502-4acb-8dfa-7994218e4c02": {
			"classDefinition": "com.sap.bpm.wfs.MailTask",
			"destinationSource": "consumer",
			"id": "mailtask4",
			"name": "Reject Email to Requester",
			"mailDefinitionRef": "f52fe563-c1c9-48bb-8180-c12ea9abaaa8"
		},
		"9a4b639e-154d-4294-94cc-6f9e243b4486": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "ExtUserReg-app-srv",
			"destinationSource": "consumer",
			"path": "/manage-user-registrations/RegistrationRequest(${context.ID})",
			"httpMethod": "PATCH",
			"requestVariable": "${context.ConfirmationRequest}",
			"headers": [{
				"name": "Content-Type",
				"value": "application/json"
			}],
			"id": "servicetask2",
			"name": "SendApprovalToBackend"
		},
		"e7f7cbc8-b7a2-4417-b46d-2fc3d03a0c75": {
			"classDefinition": "com.sap.bpm.wfs.ScriptTask",
			"reference": "/scripts/externaluserrequest/sendApproval.js",
			"id": "scripttask2",
			"name": "PerpareConfirmationResponse"
		},
		"d75e103d-2b2c-4820-83f6-c01bd927f24c": {
			"classDefinition": "com.sap.bpm.wfs.ScriptTask",
			"reference": "/scripts/externaluserrequest/sendRejection.js",
			"id": "scripttask3",
			"name": "PrepareRejectionResponse"
		},
		"766dec37-88d7-48ee-a57d-0cea2aaac22f": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow3",
			"name": "NoApproved",
			"sourceRef": "7b69565e-3ff9-497d-9710-e8592be1212a",
			"targetRef": "d75e103d-2b2c-4820-83f6-c01bd927f24c"
		},
		"b3d81247-177c-4065-9241-2fe909cdd24d": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow9",
			"name": "SequenceFlow9",
			"sourceRef": "eb2df1c2-ec26-470c-88ba-02083ed64120",
			"targetRef": "7b69565e-3ff9-497d-9710-e8592be1212a"
		},
		"66ab16f4-1e30-42ae-bb19-e18c475e19fb": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"condition": "${usertasks.usertask1.last.decision == \"approve\"}",
			"id": "sequenceflow12",
			"name": "Approved",
			"documentation": "",
			"sourceRef": "7b69565e-3ff9-497d-9710-e8592be1212a",
			"targetRef": "e7f7cbc8-b7a2-4417-b46d-2fc3d03a0c75"
		},
		"a6310b0e-e6de-4a90-b8d4-2cb8607700e2": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow16",
			"name": "SequenceFlow16",
			"sourceRef": "7274d569-ada1-45fa-b930-28996dfe223f",
			"targetRef": "48ff3f19-f502-4acb-8dfa-7994218e4c02"
		},
		"65e59ee0-a308-48c2-9ae9-011041cedae6": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow20",
			"name": "SequenceFlow20",
			"sourceRef": "9a4b639e-154d-4294-94cc-6f9e243b4486",
			"targetRef": "31cedd0c-90d1-40a5-8ff8-121cc5947475"
		},
		"3c3eff36-4db3-4b68-8bf0-59df060dee99": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow22",
			"name": "SequenceFlow22",
			"sourceRef": "e7f7cbc8-b7a2-4417-b46d-2fc3d03a0c75",
			"targetRef": "9a4b639e-154d-4294-94cc-6f9e243b4486"
		},
		"eec50302-cf8c-42ba-8d44-b00ed41a99c7": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow24",
			"name": "SequenceFlow24",
			"sourceRef": "d75e103d-2b2c-4820-83f6-c01bd927f24c",
			"targetRef": "7274d569-ada1-45fa-b930-28996dfe223f"
		},
		"cdf9ff46-c07a-4814-9cec-87d305c2af17": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow26",
			"name": "SequenceFlow26",
			"sourceRef": "31cedd0c-90d1-40a5-8ff8-121cc5947475",
			"targetRef": "2798f4e7-bc42-4fad-a248-159095a2f40a"
		},
		"7e2d41d5-04f5-4f1e-b123-74572a8da8a6": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow27",
			"name": "SequenceFlow27",
			"sourceRef": "48ff3f19-f502-4acb-8dfa-7994218e4c02",
			"targetRef": "2798f4e7-bc42-4fad-a248-159095a2f40a"
		},
		"8f53ee17-ba14-4d16-a98b-8bac7a109942": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow28",
			"name": "SequenceFlow28",
			"sourceRef": "11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3",
			"targetRef": "c37cfdf2-4d72-47a8-8c8a-303a4de1aad1"
		},
		"33c64cda-b327-4776-879d-ed4fb914c0e7": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow29",
			"name": "SequenceFlow29",
			"sourceRef": "c37cfdf2-4d72-47a8-8c8a-303a4de1aad1",
			"targetRef": "eb2df1c2-ec26-470c-88ba-02083ed64120"
		},
		"42fa7a2d-c526-4a02-b3ba-49b5168ba644": {
			"classDefinition": "com.sap.bpm.wfs.ui.Diagram",
			"symbols": {
				"df898b52-91e1-4778-baad-2ad9a261d30e": {},
				"53e54950-7757-4161-82c9-afa7e86cff2c": {},
				"3440b774-2052-4a2f-8448-84a0b5c0be32": {},
				"6acfdfc3-293d-4fe5-b1a7-3e0b29c99c2e": {},
				"6608f7a7-2918-4ff3-800a-c59539371a67": {},
				"7f247dd6-e1ed-43be-9b8c-4ccfbb3232a8": {},
				"4bbad66e-f413-43ef-ab51-ae2b5c10a41a": {},
				"84aa9f8a-4d5e-43d8-8a2c-0d3e5098da1d": {},
				"4c268313-ac09-479f-93d4-3e4760e5b242": {},
				"3f17ece5-5651-4000-a271-3d479153d29e": {},
				"bc2812a8-663f-429d-8324-42ad11be4abc": {},
				"c5f626b7-be88-45ab-89e4-5a221045b25a": {},
				"72aa378b-3ff8-4b95-9c8e-5f9e17f05051": {},
				"b3216f1f-7036-4d46-b32f-154e923044f9": {},
				"1e364a58-3aef-486c-b3ec-eb5502d5e240": {},
				"fc877600-e8fe-48f5-b785-f4a324b94055": {},
				"b81f5cc8-b45c-4763-8d94-0e5721f6defd": {},
				"dce693a2-7c58-4e38-9e4b-4a19f84f668b": {},
				"ea7dc4ef-0138-4c64-aee3-d9c67d284ccd": {},
				"a5ebc90a-e304-4e90-a3c4-15ddc5831866": {},
				"e014e949-f567-474f-afd4-9fc606504dc9": {},
				"72259fcf-483d-40ba-8e05-bdd3ef8c011d": {}
			}
		},
		"df898b52-91e1-4778-baad-2ad9a261d30e": {
			"classDefinition": "com.sap.bpm.wfs.ui.StartEventSymbol",
			"x": 100,
			"y": 100,
			"width": 32,
			"height": 32,
			"object": "11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3"
		},
		"53e54950-7757-4161-82c9-afa7e86cff2c": {
			"classDefinition": "com.sap.bpm.wfs.ui.EndEventSymbol",
			"x": 1104,
			"y": 82,
			"width": 35,
			"height": 35,
			"object": "2798f4e7-bc42-4fad-a248-159095a2f40a"
		},
		"3440b774-2052-4a2f-8448-84a0b5c0be32": {
			"classDefinition": "com.sap.bpm.wfs.ui.UserTaskSymbol",
			"x": 338.2414728659385,
			"y": 90.75,
			"width": 100,
			"height": 60,
			"object": "eb2df1c2-ec26-470c-88ba-02083ed64120"
		},
		"6acfdfc3-293d-4fe5-b1a7-3e0b29c99c2e": {
			"classDefinition": "com.sap.bpm.wfs.ui.ExclusiveGatewaySymbol",
			"x": 494.37073643296924,
			"y": 100.125,
			"object": "7b69565e-3ff9-497d-9710-e8592be1212a"
		},
		"6608f7a7-2918-4ff3-800a-c59539371a67": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "514.1207364329692,121.125 514.1207364329692,225.125",
			"sourceSymbol": "6acfdfc3-293d-4fe5-b1a7-3e0b29c99c2e",
			"targetSymbol": "b81f5cc8-b45c-4763-8d94-0e5721f6defd",
			"object": "766dec37-88d7-48ee-a57d-0cea2aaac22f"
		},
		"7f247dd6-e1ed-43be-9b8c-4ccfbb3232a8": {
			"classDefinition": "com.sap.bpm.wfs.ui.MailTaskSymbol",
			"x": 187.11860547594029,
			"y": 91.375,
			"width": 100,
			"height": 60,
			"object": "c37cfdf2-4d72-47a8-8c8a-303a4de1aad1"
		},
		"4bbad66e-f413-43ef-ab51-ae2b5c10a41a": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "388.2414728659385,117.375 506,117.375",
			"sourceSymbol": "3440b774-2052-4a2f-8448-84a0b5c0be32",
			"targetSymbol": "6acfdfc3-293d-4fe5-b1a7-3e0b29c99c2e",
			"object": "b3d81247-177c-4065-9241-2fe909cdd24d"
		},
		"84aa9f8a-4d5e-43d8-8a2c-0d3e5098da1d": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 685.4030456542969,
			"y": 222.625,
			"width": 100,
			"height": 60,
			"object": "7274d569-ada1-45fa-b930-28996dfe223f"
		},
		"4c268313-ac09-479f-93d4-3e4760e5b242": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "515.3707364329692,121.125 515.3707364329692,24.625",
			"sourceSymbol": "6acfdfc3-293d-4fe5-b1a7-3e0b29c99c2e",
			"targetSymbol": "1e364a58-3aef-486c-b3ec-eb5502d5e240",
			"object": "66ab16f4-1e30-42ae-bb19-e18c475e19fb"
		},
		"3f17ece5-5651-4000-a271-3d479153d29e": {
			"classDefinition": "com.sap.bpm.wfs.ui.MailTaskSymbol",
			"x": 875.4676513671875,
			"y": -34.6875,
			"width": 100,
			"height": 60,
			"object": "31cedd0c-90d1-40a5-8ff8-121cc5947475"
		},
		"bc2812a8-663f-429d-8324-42ad11be4abc": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "735.4030456542969,252.625 924.9030456542969,252.625",
			"sourceSymbol": "84aa9f8a-4d5e-43d8-8a2c-0d3e5098da1d",
			"targetSymbol": "c5f626b7-be88-45ab-89e4-5a221045b25a",
			"object": "a6310b0e-e6de-4a90-b8d4-2cb8607700e2"
		},
		"c5f626b7-be88-45ab-89e4-5a221045b25a": {
			"classDefinition": "com.sap.bpm.wfs.ui.MailTaskSymbol",
			"x": 874.9030456542969,
			"y": 222.625,
			"width": 100,
			"height": 60,
			"object": "48ff3f19-f502-4acb-8dfa-7994218e4c02"
		},
		"72aa378b-3ff8-4b95-9c8e-5f9e17f05051": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 685.1934356689453,
			"y": -35.078125,
			"width": 100,
			"height": 60,
			"object": "9a4b639e-154d-4294-94cc-6f9e243b4486"
		},
		"b3216f1f-7036-4d46-b32f-154e923044f9": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "735.1934356689453,-4.8828125 925.4676513671875,-4.8828125",
			"sourceSymbol": "72aa378b-3ff8-4b95-9c8e-5f9e17f05051",
			"targetSymbol": "3f17ece5-5651-4000-a271-3d479153d29e",
			"object": "65e59ee0-a308-48c2-9ae9-011041cedae6"
		},
		"1e364a58-3aef-486c-b3ec-eb5502d5e240": {
			"classDefinition": "com.sap.bpm.wfs.ui.ScriptTaskSymbol",
			"x": 465.37073643296924,
			"y": -34.875,
			"width": 100,
			"height": 60,
			"object": "e7f7cbc8-b7a2-4417-b46d-2fc3d03a0c75"
		},
		"fc877600-e8fe-48f5-b785-f4a324b94055": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "515.3707364329692,-4.9765625 685.6934356689453,-4.9765625",
			"sourceSymbol": "1e364a58-3aef-486c-b3ec-eb5502d5e240",
			"targetSymbol": "72aa378b-3ff8-4b95-9c8e-5f9e17f05051",
			"object": "3c3eff36-4db3-4b68-8bf0-59df060dee99"
		},
		"b81f5cc8-b45c-4763-8d94-0e5721f6defd": {
			"classDefinition": "com.sap.bpm.wfs.ui.ScriptTaskSymbol",
			"x": 465.37073643296924,
			"y": 223.125,
			"width": 100,
			"height": 60,
			"object": "d75e103d-2b2c-4820-83f6-c01bd927f24c"
		},
		"dce693a2-7c58-4e38-9e4b-4a19f84f668b": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "515.3707364329692,252.875 685.9030456542969,252.875",
			"sourceSymbol": "b81f5cc8-b45c-4763-8d94-0e5721f6defd",
			"targetSymbol": "84aa9f8a-4d5e-43d8-8a2c-0d3e5098da1d",
			"object": "eec50302-cf8c-42ba-8d44-b00ed41a99c7"
		},
		"ea7dc4ef-0138-4c64-aee3-d9c67d284ccd": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "925.4676513671875,-4.6875 1039.98388671875,-4.6875 1039.98388671875,101.5 1106.5,101.5",
			"sourceSymbol": "3f17ece5-5651-4000-a271-3d479153d29e",
			"targetSymbol": "53e54950-7757-4161-82c9-afa7e86cff2c",
			"object": "cdf9ff46-c07a-4814-9cec-87d305c2af17"
		},
		"a5ebc90a-e304-4e90-a3c4-15ddc5831866": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "924.9030456542969,252.625 1039.7015380859375,252.625 1039.7015380859375,100.5 1107.5,100.5",
			"sourceSymbol": "c5f626b7-be88-45ab-89e4-5a221045b25a",
			"targetSymbol": "53e54950-7757-4161-82c9-afa7e86cff2c",
			"object": "7e2d41d5-04f5-4f1e-b123-74572a8da8a6"
		},
		"e014e949-f567-474f-afd4-9fc606504dc9": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "116,118.6875 187.61860547594029,118.6875",
			"sourceSymbol": "df898b52-91e1-4778-baad-2ad9a261d30e",
			"targetSymbol": "7f247dd6-e1ed-43be-9b8c-4ccfbb3232a8",
			"object": "8f53ee17-ba14-4d16-a98b-8bac7a109942"
		},
		"72259fcf-483d-40ba-8e05-bdd3ef8c011d": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "237.11860547594029,121.375 344,121.375",
			"sourceSymbol": "7f247dd6-e1ed-43be-9b8c-4ccfbb3232a8",
			"targetSymbol": "3440b774-2052-4a2f-8448-84a0b5c0be32",
			"object": "33c64cda-b327-4776-879d-ed4fb914c0e7"
		},
		"62d7f4ed-4063-4c44-af8b-39050bd44926": {
			"classDefinition": "com.sap.bpm.wfs.LastIDs",
			"timereventdefinition": 1,
			"maildefinition": 3,
			"sequenceflow": 29,
			"startevent": 1,
			"boundarytimerevent": 1,
			"endevent": 1,
			"usertask": 2,
			"servicetask": 2,
			"scripttask": 3,
			"mailtask": 4,
			"exclusivegateway": 1,
			"parallelgateway": 3
		},
		"baa010ae-6931-4323-8edd-e36780c52e12": {
			"classDefinition": "com.sap.bpm.wfs.MailDefinition",
			"name": "maildefinition1",
			"to": "${context.Email}",
			"subject": "Your request has been received",
			"text": "Thank you for requesting external user access for our systems. We will come back to you once the decision was taken. ",
			"id": "maildefinition1"
		},
		"3d49de5c-8391-4d4e-aaa4-dee0168f8b6e": {
			"classDefinition": "com.sap.bpm.wfs.MailDefinition",
			"name": "maildefinition2",
			"to": "${context.Email}",
			"subject": "Your Request was approved",
			"text": "Your request for accessing our system has been approved.",
			"id": "maildefinition2"
		},
		"f52fe563-c1c9-48bb-8180-c12ea9abaaa8": {
			"classDefinition": "com.sap.bpm.wfs.MailDefinition",
			"name": "maildefinition3",
			"to": "${context.Email}",
			"subject": "Your Request has been rejected",
			"text": "Your request for system access has been rejected.",
			"id": "maildefinition3"
		}
	}
}