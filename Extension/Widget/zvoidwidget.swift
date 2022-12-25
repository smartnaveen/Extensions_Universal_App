//
//  zvoidwidget.swift
//  zvoidwidget
//
//  Created by Naveen Kumar on 25/12/22.
//

import WidgetKit
import SwiftUI
import Intents

/*

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct zvoidwidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var deeplinkURL: URL {
        URL(string: "widget-deeplink://widgetFamily/\(family)")!
    }

    var body: some View {
        ZStack{
            switch family {
            case .systemSmall:
                Text("Small")
                Image("img")
                    .resizable()
                    .scaledToFill()
                Text("msa")
                    .foregroundColor(.white)
                    .font(Font.custom("PermanentMarker-Regular", size: 25))
                    .widgetURL(deeplinkURL)
                
            case .systemMedium:
                Text("Medium")
                Image("img1")
                    .resizable()
                    .scaledToFill()
                Text("msa")
                    .foregroundColor(.white)
                    .font(Font.custom("PermanentMarker-Regular", size: 25))
                    .widgetURL(deeplinkURL)
            default:
                Text("Some other WidgetFamily in the future.")
            }
        }
    }
}

@main
struct zvoidwidget: Widget {
    let kind: String = "zvoidwidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            zvoidwidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct zvoidwidget_Previews: PreviewProvider {
    static var previews: some View {
        zvoidwidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

 */
