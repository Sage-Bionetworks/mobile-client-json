# ArchiveMetadata

_The metadata for an archive that can be zipped using the app developer's choice of third-party archival tools._

Type: `object`

**_Properties_**

 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appName">appName</b> `required`
	 - _Name of the app that built the archive._
	 - Type: `string`
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appVersion">appVersion</b> `required`
	 - _Version of the app that built the archive._
	 - Type: `string`
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceInfo">deviceInfo</b> `required`
	 - _Information about the specific device._
	 - Type: `string`
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceTypeIdentifier">deviceTypeIdentifier</b> `required`
	 - _Specific model identifier of the device._
	 - Type: `string`
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/files">files</b> `required`
	 - _A list of the files included in this archive._
	 - Type: `array`
	 - Items: [#/definitions/FileInfo](#/definitions/FileInfo)
    
# definitions

 - ## FileInfo
 - Type: `object`
 - **_Properties_**
	 - <b id="##FileInfo/properties/filename">filename</b> `required`
		 - _The filename of the archive object. This should be unique within the manifest._
		 - Type: `string`
		 - String format must be a "uri-reference"
	 - <b id="##FileInfo/properties/timestamp">timestamp</b> `required`
		 - _The file creation date._
		 - Type: `string`
		 - String format must be a "date-time"
	 - <b id="##FileInfo/properties/contentType">contentType</b>
		 - _The content type of the file._
		 - Type: `string`
	 - <b id="##FileInfo/properties/identifier">identifier</b>
		 - _The identifier for the result._
		 - Type: `string`
	 - <b id="##FileInfo/properties/stepPath">stepPath</b>
		 - _The full path to the result if it is within the step history._
		 - Type: `string`
	 - <b id="##FileInfo/properties/jsonSchema">jsonSchema</b>
		 - _The uri for the json schema if the content type is 'application/json'._
		 - Type: `string`
		 - String format must be a "uri"
	 - <b id="##FileInfo/properties/metadata">metadata</b>
		 - _Any additional metadata about this file._
   


_Generated with [json-schema-md-doc](https://brianwendt.github.io/json-schema-md-doc/)_ - modified by syoung 09/28/2023
