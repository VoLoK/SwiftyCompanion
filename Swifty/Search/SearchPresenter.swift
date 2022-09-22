//
//  SearchPresenter.swift
//  Swifty
//
//  Created by Clothor- on 11/2/21.
//

import Foundation

// MARK: - SearchPresentationLogic

protocol SearchPresentationLogic {
    func presentUserProfile(model: UserModel)
    func presentError()
    func presentError(message: String)
}

// MARK: - SearchPresenter

final class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    var router: SearchRoutingLogic
    
    required init(router: SearchRoutingLogic) {
        self.router = router
    }
    
    func presentUserProfile(model: UserModel) {
        guard let viewController = viewController else { return }
		let profileModel = makeViewModelFromResponse(model)
        viewController.activateInterface()
        router.routeToUserProfile(model: profileModel)
    }
    
    func presentError() {
        guard let viewController = viewController else { return }
        viewController.displayError()
    }
    
    func presentError(message: String) {
        guard let viewController = viewController else { return }
        viewController.displayError(message: message)
    }
}

// MARK: - Extension

private extension SearchPresenter {
	func makeViewModelFromResponse(_ userModel: UserModel) -> UserProfileViewModel {
		let campus = userModel.campus.last?.city ?? ""
		// TODO: Changed api response, now "new_image_url" comes instead of "image_url" I didn't figure out how to get the "new_image_url".
		let profileIcon: Data? = nil
		let cursus = makeCursus(userModel.cursusUsers)
		let projectsUsers = userModel.projectsUsers.filter { $0.project.parentID == nil && $0.finalMark != nil }
			.map { getUserProject(model: $0) }
		let achievementsUser = userModel.achievements.filter { $0.visible }
			.map { getUserAchievement(model: $0) }

		return UserProfileViewModel(
			campus: campus,
			profileIconData: profileIcon,
			staff: userModel.staff,
			cursus: cursus,
			projectsUsers: projectsUsers,
			achievements: achievementsUser
		)
	}

	func makeCursus(_ cursus: [CursusModel]) -> [UserProfileCursusViewModel] {
		var cursusViewModel: [UserProfileCursusViewModel] = []
		for model in cursus {
			var joined: String? = nil
			if let poolMonth = model.user.poolMonth,
			   let poolYear = model.user.poolYear {
				joined = "\(poolMonth) \(poolYear)"
			}
			let userLevel = getUserLevel(model.level)
			let progress = Float(model.level - model.level.rounded(.down))
			let skills = getUserSkills(model.skills)
			let cursusName = model.user.staff ? nil : model.cursus.name

			let viewModel = UserProfileCursusViewModel(
				userFullName: model.user.usualFullName ?? "",
				login: model.user.login,
				joined: joined,
				grade: model.grade,
				email: model.user.email,
				phone: model.user.phone ?? "",
				location: model.user.location,
				points: model.user.correctionPoint,
				wallet: model.user.wallet,
				userLevel: userLevel,
				progress: progress,
				skills: skills,
				cursusID: model.cursusID,
				cursusName: cursusName
			)
			cursusViewModel.append(viewModel)
		}
		return cursusViewModel
	}

	func getUserSkills(_ skills: [CursusModel.SkillsModel]) -> [UserProfileSkillsViewModel] {
		var userSkills: [UserProfileSkillsViewModel] = []
		for skill in skills {
			let level = String(format: "%.2f", skill.level)
			let progress = Float(skill.level / 21)
			let userSkill = UserProfileSkillsViewModel(
				skillExperience: "\(skill.name): \(level)",
				progress: progress
			)
			userSkills.append(userSkill)
		}
		return userSkills
	}

	func getUserLevel(_ value: Double) -> String {
		let level = Int(value.rounded(.down))
		let levelPercent: Double = (value - Double(level)) * 100
		let levelPercentFormated = String(format: "%.f", levelPercent)
		let userLevel = "level \(level) - \(levelPercentFormated)%"
		return userLevel
	}

	func getUserProject(model: ProjectsUsers) -> UserProfileProjectViewModel {
		let mark = model.finalMark ?? 0
		let validated = model.validated ?? false
		return UserProfileProjectViewModel(
			projectName: model.project.name,
			finalMark: "\(mark)",
			validated: validated
		)
	}

	func getUserAchievement(model: AchievementsModel) -> UserProfileAchievementsViewModel {
		UserProfileAchievementsViewModel(
			name: model.name,
			description: model.description,
			tier: model.tier
		)
	}
}
