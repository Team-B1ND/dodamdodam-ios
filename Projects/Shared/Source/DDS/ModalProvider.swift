//
//  DialogProvider.swift
//  Shared
//
//  Created by hhhello0507 on 7/28/24.
//

import SwiftUI
import DDS

@available(iOS 13, *)
@propertyWrapper
public struct DodamDialog: DynamicProperty {

  @EnvironmentObject private var object: DialogProvider

  public var wrappedValue: DialogProvider {
    object
  }

  public init() { }
}

@available(iOS 13, *)
@propertyWrapper
public struct DodamTimePicker: DynamicProperty {

  @EnvironmentObject private var object: TimePickerProvider

  public var wrappedValue: TimePickerProvider {
    object
  }

  public init() { }
}

@available(iOS 13, *)
@propertyWrapper
public struct DodamDatePicker: DynamicProperty {

  @EnvironmentObject private var object: DatePickerProvider

  public var wrappedValue: DatePickerProvider {
    object
  }

  public init() { }
}

