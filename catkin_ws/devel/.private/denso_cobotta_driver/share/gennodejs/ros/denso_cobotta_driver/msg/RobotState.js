// Auto-generated. Do not edit!

// (in-package denso_cobotta_driver.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class RobotState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.arm_no = null;
      this.state_code = null;
      this.state_subcode = null;
    }
    else {
      if (initObj.hasOwnProperty('arm_no')) {
        this.arm_no = initObj.arm_no
      }
      else {
        this.arm_no = 0;
      }
      if (initObj.hasOwnProperty('state_code')) {
        this.state_code = initObj.state_code
      }
      else {
        this.state_code = 0;
      }
      if (initObj.hasOwnProperty('state_subcode')) {
        this.state_subcode = initObj.state_subcode
      }
      else {
        this.state_subcode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RobotState
    // Serialize message field [arm_no]
    bufferOffset = _serializer.uint32(obj.arm_no, buffer, bufferOffset);
    // Serialize message field [state_code]
    bufferOffset = _serializer.uint32(obj.state_code, buffer, bufferOffset);
    // Serialize message field [state_subcode]
    bufferOffset = _serializer.uint32(obj.state_subcode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RobotState
    let len;
    let data = new RobotState(null);
    // Deserialize message field [arm_no]
    data.arm_no = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [state_code]
    data.state_code = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [state_subcode]
    data.state_subcode = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'denso_cobotta_driver/RobotState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '135adb9a590743fac44eca4fa4af87bc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 arm_no
    uint32 state_code
    uint32 state_subcode
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RobotState(null);
    if (msg.arm_no !== undefined) {
      resolved.arm_no = msg.arm_no;
    }
    else {
      resolved.arm_no = 0
    }

    if (msg.state_code !== undefined) {
      resolved.state_code = msg.state_code;
    }
    else {
      resolved.state_code = 0
    }

    if (msg.state_subcode !== undefined) {
      resolved.state_subcode = msg.state_subcode;
    }
    else {
      resolved.state_subcode = 0
    }

    return resolved;
    }
};

module.exports = RobotState;
