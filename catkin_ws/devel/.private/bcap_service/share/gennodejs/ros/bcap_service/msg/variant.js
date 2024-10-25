// Auto-generated. Do not edit!

// (in-package bcap_service.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class variant {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.vt = null;
      this.value = null;
    }
    else {
      if (initObj.hasOwnProperty('vt')) {
        this.vt = initObj.vt
      }
      else {
        this.vt = 0;
      }
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type variant
    // Serialize message field [vt]
    bufferOffset = _serializer.int16(obj.vt, buffer, bufferOffset);
    // Serialize message field [value]
    bufferOffset = _serializer.string(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type variant
    let len;
    let data = new variant(null);
    // Deserialize message field [vt]
    data.vt = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [value]
    data.value = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.value);
    return length + 6;
  }

  static datatype() {
    // Returns string type for a message object
    return 'bcap_service/variant';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0ff385ab5cb58d55d6c7b0d33e88693e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int16 vt
    string value
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new variant(null);
    if (msg.vt !== undefined) {
      resolved.vt = msg.vt;
    }
    else {
      resolved.vt = 0
    }

    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = ''
    }

    return resolved;
    }
};

module.exports = variant;
