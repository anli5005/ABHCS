import SwiftUI

enum TagType: Equatable, Hashable {
    case eventCategory
    case contentPersonRole
    case skillLevel
    case track
    case eventIncludes
    case organizationType
    case orgPersonRelationship
    case venue
    case organizer
    case subjectMatter
    case exhibitorTier
    case modality
    
    static var detailTypes: [Self] {
        [
            .organizer,
            .organizationType,
            .subjectMatter,
            .eventIncludes
        ]
    }
    
    var iconName: String {
        switch self {
        case .eventCategory:
            "folder"
        case .contentPersonRole:
            "person"
        case .skillLevel:
            "book.pages"
        case .track:
            "point.topleft.down.to.point.bottomright.curvepath"
        case .eventIncludes:
            "plus.circle"
        case .organizationType:
            "building.2"
        case .orgPersonRelationship:
            "person.text.rectangle"
        case .venue:
            "building.columns"
        case .organizer:
            "building.2.crop.circle"
        case .subjectMatter:
            "info.circle.text.page"
        case .exhibitorTier:
            "medal"
        case .modality:
            "network"
        }
    }
}

struct Tag: Identifiable, Equatable, Comparable, Hashable {
    let type: TagType
    let id: Int
    let label: String
    let backgroundColor: String
    let foregroundColor: String
    var iconName: String?

    var color: Color {
        Color(hex: backgroundColor)
    }
    
    static func <(_ lhs: Tag, _ rhs: Tag) -> Bool {
        return lhs.id < rhs.id
    }
}

struct Category {
    let name: String
    let tags: [Tag]
}

let categories: [Category] = [
Category(
    name: "Event Category",
    tags: [
        Tag(type: .eventCategory, id: 47905, label: "DEF CON Training (Paid)", backgroundColor: "#40C693", foregroundColor: "#ffffff", iconName: "dollarsign"),
        Tag(type: .eventCategory, id: 48011, label: "Event", backgroundColor: "#8248f8", foregroundColor: "#ffffff", iconName: "calendar"),
        Tag(type: .eventCategory, id: 48161, label: "Creator Talk/Panel", backgroundColor: "#2831B6", foregroundColor: "#ffffff", iconName: "music.microphone"),
        Tag(type: .eventCategory, id: 47607, label: "DEF CON Official Talk", backgroundColor: "#5452D4", foregroundColor: "#FFFFFF", iconName: "star.fill"),
        Tag(type: .eventCategory, id: 48163, label: "Creator Workshop", backgroundColor: "#1DB6D7", foregroundColor: "#ffffff", iconName: "paintbrush.pointed.fill"),
        Tag(type: .eventCategory, id: 48158, label: "Misc", backgroundColor: "#57B7BC", foregroundColor: "#ffffff", iconName: "ellipsis"),
        Tag(type: .eventCategory, id: 48010, label: "Contest", backgroundColor: "#4685ac", foregroundColor: "#ffffff", iconName: "medal.fill"),
        Tag(type: .eventCategory, id: 48160, label: "DEF CON Workshop", backgroundColor: "#4C71F5", foregroundColor: "#ffffff", iconName: "wrench.adjustable.fill"),
        Tag(type: .eventCategory, id: 48051, label: "Party", backgroundColor: "#6c33ec", foregroundColor: "#ffffff", iconName: "party.popper.fill"),
        Tag(type: .eventCategory, id: 48162, label: "Creator Event", backgroundColor: "#77514C", foregroundColor: "#ffffff", iconName: "paintpalette.fill"),
        Tag(type: .eventCategory, id: 48052, label: "Meetup", backgroundColor: "#36b7c0", foregroundColor: "#ffffff", iconName: "person.3.sequence.fill"),
        Tag(type: .eventCategory, id: 48279, label: "Vendor Book Signing", backgroundColor: "#d5ad95", foregroundColor: "#ffffff", iconName: "signature"),
        Tag(type: .eventCategory, id: 48164, label: "Entertainment", backgroundColor: "#6EC720", foregroundColor: "#ffffff", iconName: "popcorn.fill"),
        Tag(type: .eventCategory, id: 48159, label: "Demo Lab", backgroundColor: "#57B2C1", foregroundColor: "#ffffff", iconName: "atom")
    ]
),
Category(
    name: "Content-Person Role",
    tags: [
        Tag(type: .contentPersonRole, id: 48377, label: "Performer", backgroundColor: "#8EBCA0", foregroundColor: "#ffffff"),
        Tag(type: .contentPersonRole, id: 48237, label: "Instructor", backgroundColor: "#2891AB", foregroundColor: "#ffffff"),
        Tag(type: .contentPersonRole, id: 48171, label: "Moderator", backgroundColor: "#8A7F61", foregroundColor: "#ffffff"),
        Tag(type: .contentPersonRole, id: 48333, label: "Remote Trainer", backgroundColor: "#73B8FE", foregroundColor: "#ffffff"),
        Tag(type: .contentPersonRole, id: 47608, label: "Speaker", backgroundColor: "#67566D", foregroundColor: "#FFFFFF"),
        Tag(type: .contentPersonRole, id: 48172, label: "Presenter", backgroundColor: "#615F5D", foregroundColor: "#ffffff"),
        Tag(type: .contentPersonRole, id: 48170, label: "Panelist", backgroundColor: "#2BBBB6", foregroundColor: "#ffffff"),
        Tag(type: .contentPersonRole, id: 48173, label: "Author", backgroundColor: "#32F174", foregroundColor: "#ffffff"),
        Tag(type: .contentPersonRole, id: 48332, label: "Trainer", backgroundColor: "#D3FB80", foregroundColor: "#ffffff")
    ]
),
Category(
    name: "Skill Level",
    tags: [
        Tag(type: .skillLevel, id: 48242, label: "Intermediate", backgroundColor: "#5331BE", foregroundColor: "#ffffff"),
        Tag(type: .skillLevel, id: 48243, label: "Advanced", backgroundColor: "#962B09", foregroundColor: "#ffffff"),
        Tag(type: .skillLevel, id: 47609, label: "Beginner", backgroundColor: "#3A830C", foregroundColor: "#FFFFFF"),
        Tag(type: .skillLevel, id: 48508, label: "All Audiences", backgroundColor: "#76C761", foregroundColor: "#ffffff")
    ]
),
Category(
    name: "Track",
    tags: [
        Tag(type: .track, id: 47610, label: "Default", backgroundColor: "#6EF136", foregroundColor: "#FFFFFF")
    ]
),
Category(
    name: "Event-Includes",
    tags: [
        Tag(type: .eventIncludes, id: 48165, label: "Exploit 🪲", backgroundColor: "#705093", foregroundColor: "#ffffff"),
        Tag(type: .eventIncludes, id: 48166, label: "Tool 🛠", backgroundColor: "#7E50CB", foregroundColor: "#ffffff"),
        Tag(type: .eventIncludes, id: 47611, label: "Demo 💻", backgroundColor: "#449961", foregroundColor: "#FFFFFF")
    ]
),
Category(
    name: "Organization Type",
    tags: [
        Tag(type: .organizationType, id: 47613, label: "Vendor", backgroundColor: "#782E80", foregroundColor: "#FFFFFF"),
        Tag(type: .organizationType, id: 47621, label: "Community", backgroundColor: "#6C48D6", foregroundColor: "#ffffff"),
        Tag(type: .organizationType, id: 47622, label: "Contest", backgroundColor: "#2B27BB", foregroundColor: "#ffffff"),
        Tag(type: .organizationType, id: 47616, label: "Misc", backgroundColor: "#437660", foregroundColor: "#FFFFFF"),
        Tag(type: .organizationType, id: 47615, label: "Exhibitor", backgroundColor: "#96FC3A", foregroundColor: "#FFFFFF"),
        Tag(type: .organizationType, id: 47614, label: "Village", backgroundColor: "#8BB282", foregroundColor: "#FFFFFF"),
        Tag(type: .organizationType, id: 47612, label: "Sponsor", backgroundColor: "#1E9C84", foregroundColor: "#FFFFFF"),
        Tag(type: .organizationType, id: 48075, label: "DEF CON Department", backgroundColor: "#298A23", foregroundColor: "#ffffff")
    ]
),
Category(
    name: "Org-Person Relationship",
    tags: [
        Tag(type: .orgPersonRelationship, id: 47617, label: "Member", backgroundColor: "#54A2C0", foregroundColor: "#FFFFFF")
    ]
),
Category(
    name: "Venue",
    tags: [
        Tag(type: .venue, id: 48525, label: "LVCC-L3", backgroundColor: "#8E2499", foregroundColor: "#ffffff"),
        Tag(type: .venue, id: 48527, label: "LVCC-L1", backgroundColor: "#82B62A", foregroundColor: "#ffffff"),
        Tag(type: .venue, id: 48526, label: "LVCC-L2", backgroundColor: "#70C7A4", foregroundColor: "#ffffff"),
        Tag(type: .venue, id: 47618, label: "Default", backgroundColor: "#2C970D", foregroundColor: "#FFFFFF")
    ]
),
Category(
    name: "Organizer",
    tags: [
        Tag(type: .organizer, id: 48431, label: "ICS Village CTF", backgroundColor: "#7E5C00", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48097, label: "AppSec Village", backgroundColor: "#104972", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48156, label: "VETCON", backgroundColor: "#4EDF9C", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48136, label: "DEF CON Groups VR (DCGVR)", backgroundColor: "#914472", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48141, label: "Illumicon", backgroundColor: "#3E6A98", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48151, label: "Operating Systems Community", backgroundColor: "#8806A8", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48131, label: "DC Maker's Community", backgroundColor: "#25B4C7", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48110, label: "ICS Village", backgroundColor: "#6B162B", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48152, label: "Queercon Community Lounge", backgroundColor: "#8E5413", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48132, label: "DC NextGen", backgroundColor: "#68790D", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48127, label: ".edu Community", backgroundColor: "#6D6449", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48142, label: "La Villa", backgroundColor: "#A43230", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48157, label: "Women in Security and Privacy (WISP)", backgroundColor: "#874153", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48294, label: "Battle of the Bots: Vishing Edition", backgroundColor: "#4EA20C", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48143, label: "Lonely Hackers Club", backgroundColor: "#76ECAA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48133, label: "DDoS Community", backgroundColor: "#5A5E5E", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48148, label: "Nix Vegas Community", backgroundColor: "#6653E1", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48138, label: "Hackers With Disabilities (HDA)", backgroundColor: "#28AFBA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48128, label: "Badgelife Community", backgroundColor: "#413B6E", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48093, label: "BBWIC Foundation", backgroundColor: "#2FE545", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48153, label: "Retro Tech Community", backgroundColor: "#6077D0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48091, label: "Cycle Override", backgroundColor: "#400F94", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48092, label: "The Pwnie Awards", backgroundColor: "#2655A0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48099, label: "Biohacking Village", backgroundColor: "#23A839", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48094, label: "AI Village", backgroundColor: "#30C7AD", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48432, label: "Octopus Game 4: The Order of the White Tentacle", backgroundColor: "#4FA311", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48433, label: "PROJECT ACCESS: A Fox Hunt in the Shadows", backgroundColor: "#939412", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48434, label: "Password Village Contest", backgroundColor: "#31F1C2", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48435, label: "Phish Stories", backgroundColor: "#37C398", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48436, label: "PhreakMe", backgroundColor: "#1CF180", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48437, label: "Pinball High Score Contest", backgroundColor: "#58A88E", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48438, label: "REALI7Y OVERRUN", backgroundColor: "#41F863", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48439, label: "Radio Frequency Capture the Flag", backgroundColor: "#6D1763", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48440, label: "Raitlin's Challenge presented by the Illuminati Party®", backgroundColor: "#8346F7", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48443, label: "Scambait Village Contest", backgroundColor: "#3B66AF", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48444, label: "Silk's Roadhouse", backgroundColor: "#4523FA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48445, label: "TeleChallenge", backgroundColor: "#8CF77E", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48446, label: "The Gold Bug", backgroundColor: "#97FC06", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48447, label: "Tin Foil Hat Contest", backgroundColor: "#8CB7C0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48448, label: "spyVspy", backgroundColor: "#231505", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48449, label: "venator aurum", backgroundColor: "#88210F", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48450, label: "warl0ck gam3z CTF", backgroundColor: "#74E253", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48122, label: "Red Team Village", backgroundColor: "#ff0044", foregroundColor: "#ffffff"),
        Tag(type: .organizer, id: 48409, label: "Blue Team Village CTF", backgroundColor: "#668cff", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48442, label: "Red Team Village CTF", backgroundColor: "#ff0044", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48441, label: "Red Alert ICS CTF", backgroundColor: "#881805", foregroundColor: "#ffffff"),
        Tag(type: .organizer, id: 48359, label: "Kubernetes CTF", backgroundColor: "#537116", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48393, label: "Hacking Boundary Ship Terminal", backgroundColor: "#516BAC", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48103, label: "Car Hacking Village", backgroundColor: "#2054DA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48108, label: "GameHacking.GG", backgroundColor: "#7DA760", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48105, label: "Crypto Privacy Village", backgroundColor: "#289C3B", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48102, label: "Bug Bounty Village", backgroundColor: "#131543", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48104, label: "Cloud Village", backgroundColor: "#7FBF96", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48139, label: "Hackers.town Community", backgroundColor: "#1936BC", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48129, label: "Code Breaker", backgroundColor: "#78A731", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48134, label: "DEF CON Academy", backgroundColor: "#4054CB", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48154, label: "The Diana Initiative", backgroundColor: "#434AAA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48149, label: "Noob Community", backgroundColor: "#1B20E0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48144, label: "Loong Community", backgroundColor: "#170F77", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48101, label: "Blue Team Village (BTV)", backgroundColor: "#668cff", foregroundColor: "#ffffff"),
        Tag(type: .organizer, id: 48113, label: "Malware Village", backgroundColor: "#281600", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48119, label: "Quantum Village", backgroundColor: "#3E847E", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48095, label: "Adversary Village", backgroundColor: "#48D18F", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48112, label: "Lock Pick Village", backgroundColor: "#34E429", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48109, label: "Hardware Hacking and Soldering Skills Village (HHV-SSV)", backgroundColor: "#5914FC", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48150, label: "OWASP Community", backgroundColor: "#330EEB", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48096, label: "Aerospace Village", backgroundColor: "#46F5D8", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48004, label: "Hack3r Runw@y Contest", backgroundColor: "#49777C", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48000, label: "DEF CON Beard and Mustache Contest", backgroundColor: "#307DBB", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48001, label: "Aw, man...pages!", backgroundColor: "#921CB1", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48002, label: "Pub Quiz at DEF CON", backgroundColor: "#182D58", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48358, label: "Hac-Man", backgroundColor: "#A6D440", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48376, label: "Cloud Village CTF", backgroundColor: "#87F7F0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48394, label: "DEF CON Scavenger Hunt", backgroundColor: "#48D7B1", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48396, label: "Call Center Village Contest", backgroundColor: "#3FA87B", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48397, label: "CMD+CTRL Cloud Cyber Range", backgroundColor: "#788B90", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48244, label: "Cyber Wargames", backgroundColor: "#6C97BB", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48293, label: "Social Engineering Community Vishing Competition (SECVC)", backgroundColor: "#143544", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48135, label: "DEF CON Groups (DCG)", backgroundColor: "#2019A8", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48155, label: "The Diana Initiative's Quiet Room", backgroundColor: "#8D27D5", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48145, label: "Memorial Chamber", backgroundColor: "#649BAE", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48140, label: "Hard Hat Brigade", backgroundColor: "#737879", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48130, label: "Cryptocurrency Community", backgroundColor: "#1368F0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48137, label: "Friends of Bill W", backgroundColor: "#843682", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48147, label: "NMDP (Formally Be The Match)", backgroundColor: "#504F11", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48146, label: "Mobile Hacking Community", backgroundColor: "#4191C7", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48115, label: "Packet Hacking Village", backgroundColor: "#8DB0EA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48118, label: "Policy @ DEF CON", backgroundColor: "#11CEEC", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48053, label: "Ham Radio Village", backgroundColor: "#4D6BEB", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48116, label: "Payment Village", backgroundColor: "#824414", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48126, label: "Voting Village", backgroundColor: "#5B688B", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48125, label: "Telecom Village", backgroundColor: "#8BA8B4", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48123, label: "Social Engineering Community Village", backgroundColor: "#8B63E0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48124, label: "Tamper-Evident Village", backgroundColor: "#1E5CB4", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48100, label: "Blacks In Cyber Village", backgroundColor: "#8966FA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48117, label: "Physical Security Village", backgroundColor: "#4ED4D0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48107, label: "Embedded Systems Village", backgroundColor: "#2CB071", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48111, label: "IOT Village", backgroundColor: "#7D08A4", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48121, label: "Recon Village", backgroundColor: "#28DC1C", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48098, label: "Artificial Intelligence Cyber Challenge (AIxCC)", backgroundColor: "#332C03", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48120, label: "Radio Frequency Village", backgroundColor: "#8859BB", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48106, label: "Data Duplication Village", backgroundColor: "#91C7B8", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48114, label: "Maritime Hacking Village", backgroundColor: "#8B5B8F", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48054, label: "Can it Ham?", backgroundColor: "#39963A", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48003, label: "Taskmooster", backgroundColor: "#40511C", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48005, label: "AI Art Battle", backgroundColor: "#739427", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48006, label: "EFF Tech Trivia", backgroundColor: "#938A41", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48007, label: "Hacker Jeopardy", backgroundColor: "#55A49D", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48008, label: "Whose Slide Is It Anyway?", backgroundColor: "#247713", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48009, label: "Feet Feud (Hacker Family Feud)", backgroundColor: "#53D742", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48399, label: "Beverage Cooling Contraption Contest", backgroundColor: "#11FEFB", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48400, label: "5N4CK3Y", backgroundColor: "#7CE600", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48401, label: "$$$$$_<CAPTURE_THE_COIN>_$$$$$", backgroundColor: "#637107", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48402, label: "$unL1ght Sh4d0w5", backgroundColor: "#588E1C", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48403, label: ".ssh/ Social Scavenger Hunt", backgroundColor: "#3EDC50", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48404, label: "? Cube", backgroundColor: "#46E395", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48405, label: "Adversary Wars CTF", backgroundColor: "#27312D", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48406, label: "Band Camp: Hacker My Music", backgroundColor: "#535C37", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48407, label: "Betting on Your Digital Rights: 4th Annual EFF Benefit Poker Tournament at DEF CON 33", backgroundColor: "#5A500F", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48408, label: "Blacks In Cybersecurity Village Capture The Flag Competition", backgroundColor: "#7645F2", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48410, label: "Bug Bounty Village CTF", backgroundColor: "#5E1C40", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48411, label: "Capture The Packet", backgroundColor: "#1B8789", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48412, label: "Car Hacking Village Capture the Flag (CTF)", backgroundColor: "#1BA8AD", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48413, label: "Code Breaker Challenge", backgroundColor: "#32FC0D", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48414, label: "Code CRIMSON: Healthcare in Trauma", backgroundColor: "#1BFD20", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48415, label: "Creative Writing Short Story Contest", backgroundColor: "#71694A", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48416, label: "Cryptocurrency Challenge", backgroundColor: "#18ED74", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48417, label: "Cyber Defender - The Game", backgroundColor: "#68F5FF", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48418, label: "DARPA's Artificial Intelligence Cyber Challenge (AIxCC)", backgroundColor: "#5BB199", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48419, label: "DC Sticker Design Contest", backgroundColor: "#1C5C5E", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48420, label: "DC's Next Top Threat Model", backgroundColor: "#5F2A87", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48421, label: "DEF CON CTF", backgroundColor: "#79FFA4", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48422, label: "DEF CON MUD", backgroundColor: "#18E84F", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48423, label: "Darknet-NG", backgroundColor: "#54F4FA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48424, label: "Dozier Drill Lockpicking Challenge", backgroundColor: "#6B73B2", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48425, label: "Dungeons@Defcon", backgroundColor: "#77838B", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48426, label: "Embedded CTF", backgroundColor: "#22A8C0", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48427, label: "GenSec CTF", backgroundColor: "#2671B8", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48428, label: "HTB CTF: Data Dystopia", backgroundColor: "#191949", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48429, label: "HardWired", backgroundColor: "#7A22DA", foregroundColor: "#FFFFFF"),
        Tag(type: .organizer, id: 48430, label: "Hardware Hacking Village CTF", backgroundColor: "#28A065", foregroundColor: "#FFFFFF")
    ]
),
Category(
    name: "Subject Matter",
    tags: [
        Tag(type: .subjectMatter, id: 48261, label: "Robotics", backgroundColor: "#105478", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48251, label: "Cloud", backgroundColor: "#3BEAFA", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48255, label: "Malware", backgroundColor: "#2FE440", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48259, label: "Purple Team", backgroundColor: "#91AF71", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48263, label: "Security Conscious Users and Radio Enthusiasts", backgroundColor: "#243CFB", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48258, label: "Offense/Red Team", backgroundColor: "#34FE5C", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48257, label: "Mobile", backgroundColor: "#892C97", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 47620, label: "AI", backgroundColor: "#540E26", foregroundColor: "#FFFFFF"),
        Tag(type: .subjectMatter, id: 48253, label: "DevOps", backgroundColor: "#2A4577", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48254, label: "Hardware", backgroundColor: "#3B0BA8", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48250, label: "AppSec", backgroundColor: "#5C3DAB", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48262, label: "SecOps", backgroundColor: "#887839", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48252, label: "Defense/Blue Team", backgroundColor: "#43C93C", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48256, label: "Medical/PPE Open Source Hardware", backgroundColor: "#7FB7C4", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48260, label: "Reverse Engineering", backgroundColor: "#7CBAB2", foregroundColor: "#ffffff"),
        Tag(type: .subjectMatter, id: 48264, label: "Threat Hunting", backgroundColor: "#42D729", foregroundColor: "#ffffff")
    ]
),
Category(
    name: "Exhibitor Tier",
    tags: [
        Tag(type: .exhibitorTier, id: 48240, label: "Silver", backgroundColor: "#c5e063", foregroundColor: "#ffffff"),
        Tag(type: .exhibitorTier, id: 48241, label: "Bronze", backgroundColor: "#1b67f4", foregroundColor: "#ffffff")
    ]
),
Category(
    name: "Modality",
    tags: [
        Tag(type: .modality, id: 48246, label: "Virtual", backgroundColor: "#b41c08", foregroundColor: "#ffffff"),
        Tag(type: .modality, id: 48247, label: "Hybrid", backgroundColor: "#4b07d5", foregroundColor: "#ffffff"),
        Tag(type: .modality, id: 48245, label: "On-site", backgroundColor: "#8531f6", foregroundColor: "#ffffff")
    ]
)
]

let tagDict = Dictionary(uniqueKeysWithValues: categories.flatMap { $0.tags }.map { (key: $0.id, value: $0) })

private extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
