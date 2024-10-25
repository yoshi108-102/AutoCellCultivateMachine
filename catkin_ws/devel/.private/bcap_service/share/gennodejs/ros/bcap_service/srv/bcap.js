// Auto-generated. Do not edit!

// (in-package bcap_service.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let variant = require('../msg/variant.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class bcapRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.func_id = null;
      this.vntArgs = null;
    }
    else {
      if (initObj.hasOwnProperty('func_id')) {
        this.func_id = initObj.func_id
      }
      else {
        this.func_id = 0;
      }
      if (initObj.hasOwnProperty('vntArgs')) {
        this.vntArgs = initObj.vntArgs
      }
      else {
        this.vntArgs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type bcapRequest
    // Serialize message field [func_id]
    bufferOffset = _serializer.int32(obj.func_id, buffer, bufferOffset);
    // Serialize message field [vntArgs]
    // Serialize the length for message field [vntArgs]
    bufferOffset = _serializer.uint32(obj.vntArgs.length, buffer, bufferOffset);
    obj.vntArgs.forEach((val) => {
      bufferOffset = variant.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type bcapRequest
    let len;
    let data = new bcapRequest(null);
    // Deserialize message field [func_id]
    data.func_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [vntArgs]
    // Deserialize array length for message field [vntArgs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.vntArgs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.vntArgs[i] = variant.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.vntArgs.forEach((val) => {
      length += variant.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'bcap_service/bcapRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e2e62a99900f0dacb6b7c7114cde3983';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 func_id
    variant[] vntArgs
    
    ================================================================================
    MSG: bcap_service/variant
    int16 vt
    string value
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new bcapRequest(null);
    if (msg.func_id !== undefined) {
      resolved.func_id = msg.func_id;
    }
    else {
      resolved.func_id = 0
    }

    if (msg.vntArgs !== undefined) {
      resolved.vntArgs = new Array(msg.vntArgs.length);
      for (let i = 0; i < resolved.vntArgs.length; ++i) {
        resolved.vntArgs[i] = variant.Resolve(msg.vntArgs[i]);
      }
    }
    else {
      resolved.vntArgs = []
    }

    return resolved;
    }
};

class bcapResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.HRESULT = null;
      this.vntRet = null;
    }
    else {
      if (initObj.hasOwnProperty('HRESULT')) {
        this.HRESULT = initObj.HRESULT
      }
      else {
        this.HRESULT = 0;
      }
      if (initObj.hasOwnProperty('vntRet')) {
        this.vntRet = initObj.vntRet
      }
      else {
        this.vntRet = new variant();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type bcapResponse
    // Serialize message field [HRESULT]
    bufferOffset = _serializer.int32(obj.HRESULT, buffer, bufferOffset);
    // Serialize message field [vntRet]
    bufferOffset = variant.serialize(obj.vntRet, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type bcapResponse
    let len;
    let data = new bcapResponse(null);
    // Deserialize message field [HRESULT]
    data.HRESULT = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [vntRet]
    data.vntRet = variant.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += variant.getMessageSize(object.vntRet);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'bcap_service/bcapResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '71670d22c1b3a79073449b5cc4047e38';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 HRESULT
    variant vntRet
    
    ================================================================================
    MSG: bcap_service/variant
    int16 vt
    string value
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new bcapResponse(null);
    if (msg.HRESULT !== undefined) {
      resolved.HRESULT = msg.HRESULT;
    }
    else {
      resolved.HRESULT = 0
    }

    if (msg.vntRet !== undefined) {
      resolved.vntRet = variant.Resolve(msg.vntRet)
    }
    else {
      resolved.vntRet = new variant()
    }

    return resolved;
    }
};

module.exports = {
  Request: bcapRequest,
  Response: bcapResponse,
  md5sum() { return 'd7da50225be5d246d6e3baaab811da16'; },
  datatype() { return 'bcap_service/bcap'; }
};
