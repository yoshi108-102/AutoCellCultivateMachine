// Auto-generated. Do not edit!

// (in-package denso_robot_core.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ExJoints = require('./ExJoints.js');

//-----------------------------------------------------------

class PoseData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.value = null;
      this.type = null;
      this.pass = null;
      this.exjoints = null;
    }
    else {
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = [];
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('pass')) {
        this.pass = initObj.pass
      }
      else {
        this.pass = 0;
      }
      if (initObj.hasOwnProperty('exjoints')) {
        this.exjoints = initObj.exjoints
      }
      else {
        this.exjoints = new ExJoints();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PoseData
    // Serialize message field [value]
    bufferOffset = _arraySerializer.float32(obj.value, buffer, bufferOffset, null);
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    // Serialize message field [pass]
    bufferOffset = _serializer.int32(obj.pass, buffer, bufferOffset);
    // Serialize message field [exjoints]
    bufferOffset = ExJoints.serialize(obj.exjoints, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PoseData
    let len;
    let data = new PoseData(null);
    // Deserialize message field [value]
    data.value = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pass]
    data.pass = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [exjoints]
    data.exjoints = ExJoints.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.value.length;
    length += ExJoints.getMessageSize(object.exjoints);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'denso_robot_core/PoseData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9b62dc5261dfb262aa32713ca52458d1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32[] value
    int32     type
    int32     pass
    ExJoints  exjoints
    
    
    ================================================================================
    MSG: denso_robot_core/ExJoints
    int32    mode
    Joints[] joints
    
    
    ================================================================================
    MSG: denso_robot_core/Joints
    int32   joint
    float64 value
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PoseData(null);
    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = []
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.pass !== undefined) {
      resolved.pass = msg.pass;
    }
    else {
      resolved.pass = 0
    }

    if (msg.exjoints !== undefined) {
      resolved.exjoints = ExJoints.Resolve(msg.exjoints)
    }
    else {
      resolved.exjoints = new ExJoints()
    }

    return resolved;
    }
};

module.exports = PoseData;
