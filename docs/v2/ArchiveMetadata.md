# ArchiveMetadata

_The metadata for an archive that can be zipped using the app developer's choice of third-party archival tools._

Type: `object`

<i id="https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json">path: #https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json</i>

&#36;schema: [http://json-schema.org/draft-07/schema#](http://json-schema.org/draft-07/schema#)

<b id="httpssage-bionetworks.github.iomobile-client-jsonschemasv2archivemetadata.json">&#36;id: https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json</b>

Example values: 

 1. `[object Object]`
**_Properties_**

 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appName">appName</b> `required`
	 - _Name of the app that built the archive._
	 - Type: `string`
	 - <i id="https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appName">path: #https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appName</i>
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appVersion">appVersion</b> `required`
	 - _Version of the app that built the archive._
	 - Type: `string`
	 - <i id="https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appVersion">path: #https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/appVersion</i>
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceInfo">deviceInfo</b> `required`
	 - _Information about the specific device._
	 - Type: `string`
	 - <i id="https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceInfo">path: #https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceInfo</i>
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceTypeIdentifier">deviceTypeIdentifier</b> `required`
	 - _Specific model identifier of the device._
	 - Type: `string`
	 - <i id="https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceTypeIdentifier">path: #https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/deviceTypeIdentifier</i>
 - <b id="#https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/files">files</b> `required`
	 - _A list of the files included in this archive._
	 - Type: `array`
	 - <i id="https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/files">path: #https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/files</i>
		 - **_Items_**
		 - <i id="https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/files/items">path: #https://sage-bionetworks.github.io/mobile-client-json/schemas/v2/ArchiveMetadata.json/properties/files/items</i>
		 - &#36;ref: [#/definitions/FileInfo](#/definitions/FileInfo)
# definitions

**_FileInfo_**

 - ## FileInfo
 - Type: `object`
 - <i id="#FileInfo">path: ##FileInfo</i>
 - <b id="fileinfo">&#36;id: #FileInfo</b>
 - Example values: 
	 1. `[object Object]`
 - **_Properties_**
	 - <b id="##FileInfo/properties/filename">filename</b> `required`
		 - _The filename of the archive object. This should be unique within the manifest._
		 - Type: `string`
		 - <i id="#FileInfo/properties/filename">path: ##FileInfo/properties/filename</i>
		 - String format must be a "uri-reference"
	 - <b id="##FileInfo/properties/timestamp">timestamp</b> `required`
		 - _The file creation date._
		 - Type: `string`
		 - <i id="#FileInfo/properties/timestamp">path: ##FileInfo/properties/timestamp</i>
		 - String format must be a "date-time"
	 - <b id="##FileInfo/properties/contentType">contentType</b>
		 - _The content type of the file._
		 - Type: `string`
		 - <i id="#FileInfo/properties/contentType">path: ##FileInfo/properties/contentType</i>
	 - <b id="##FileInfo/properties/identifier">identifier</b>
		 - _The identifier for the result._
		 - Type: `string`
		 - <i id="#FileInfo/properties/identifier">path: ##FileInfo/properties/identifier</i>
	 - <b id="##FileInfo/properties/stepPath">stepPath</b>
		 - _The full path to the result if it is within the step history._
		 - Type: `string`
		 - <i id="#FileInfo/properties/stepPath">path: ##FileInfo/properties/stepPath</i>
	 - <b id="##FileInfo/properties/jsonSchema">jsonSchema</b>
		 - _The uri for the json schema if the content type is 'application/json'._
		 - Type: `string`
		 - <i id="#FileInfo/properties/jsonSchema">path: ##FileInfo/properties/jsonSchema</i>
		 - String format must be a "uri"
	 - <b id="##FileInfo/properties/metadata">metadata</b>
		 - _Any additional metadata about this file._
		 - <i id="#FileInfo/properties/metadata">path: ##FileInfo/properties/metadata</i>



_Generated with [json-schema-md-doc](https://brianwendt.github.io/json-schema-md-doc/)_