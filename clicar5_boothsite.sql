-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 01, 2015 at 03:50 PM
-- Server version: 5.5.42-cll
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `clicar5_boothsite`
--

-- --------------------------------------------------------

--
-- Table structure for table `activitytbl`
--

CREATE TABLE IF NOT EXISTS `activitytbl` (
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'the time at which the activity occurred',
  `fkUsername` varchar(32) NOT NULL COMMENT 'the user who did the activity',
  `fkIndex` int(32) NOT NULL COMMENT 'eg: booth number, user number, etc.',
  `type` varchar(32) NOT NULL COMMENT 'the type of event'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `activity_speeduptbl`
--

CREATE TABLE IF NOT EXISTS `activity_speeduptbl` (
  `fkUsername` varchar(32) NOT NULL,
  `dateRangeEnd` datetime NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains the oldest date required to show 10 pages of activity for a user.';

-- --------------------------------------------------------

--
-- Table structure for table `agreementpendingtbl`
--

CREATE TABLE IF NOT EXISTS `agreementpendingtbl` (
  `fkUsername` varchar(32) NOT NULL,
  `code` varchar(256) NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `boothcommentrangetbl`
--

CREATE TABLE IF NOT EXISTS `boothcommentrangetbl` (
  `fkBoothNumber` int(32) NOT NULL,
  `fkOldestComment` int(32) NOT NULL,
  `fkNewestComment` int(32) NOT NULL,
  PRIMARY KEY (`fkBoothNumber`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `boothnumbers`
--

CREATE TABLE IF NOT EXISTS `boothnumbers` (
  `pkNumber` int(11) NOT NULL AUTO_INCREMENT,
  `requestHash` varchar(64) NOT NULL,
  `imageTitle` varchar(32) NOT NULL,
  `filetype` varchar(4) NOT NULL DEFAULT 'jpg',
  `imageHeightProp` float NOT NULL DEFAULT '0.75',
  `blurb` varchar(10000) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkUsername` varchar(32) NOT NULL,
  `success` tinyint(1) NOT NULL DEFAULT '0',
  `userBoothNumber` int(32) NOT NULL,
  `source` varchar(32) NOT NULL DEFAULT 'unknown',
  `isPublic` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is this specific booth public?',
  UNIQUE KEY `pkNumber` (`pkNumber`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Creates a new number for each new booth and assigns it to th' AUTO_INCREMENT=18968 ;

-- --------------------------------------------------------

--
-- Table structure for table `booth_full_record_tbl`
--

CREATE TABLE IF NOT EXISTS `booth_full_record_tbl` (
  `fkUsername` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fkNumber` int(10) NOT NULL,
  PRIMARY KEY (`fkNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='A record of all booths posted.  Nothing gets deleted from this table, even if th';

-- --------------------------------------------------------

--
-- Table structure for table `commentstbl`
--

CREATE TABLE IF NOT EXISTS `commentstbl` (
  `pkCommentNumber` int(32) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `extension` varchar(5) NOT NULL DEFAULT 'jpg',
  `fkNumber` int(11) NOT NULL,
  `fkUsername` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `zone` varchar(16) NOT NULL DEFAULT 'EDT_A',
  `commentBody` varchar(10000) NOT NULL,
  `hasPhoto` tinyint(1) NOT NULL DEFAULT '0',
  `imageHeightProp` double NOT NULL DEFAULT '0.75',
  `adminPost` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pkCommentNumber`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=80197 ;

-- --------------------------------------------------------

--
-- Table structure for table `currencytbl`
--

CREATE TABLE IF NOT EXISTS `currencytbl` (
  `fkUsername` varchar(32) NOT NULL,
  `beta` int(11) NOT NULL DEFAULT '0' COMMENT 'Beta is the currency of this site.',
  PRIMARY KEY (`fkUsername`),
  UNIQUE KEY `fkUsername` (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `emailchangetbl`
--

CREATE TABLE IF NOT EXISTS `emailchangetbl` (
  `fkUsername` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL,
  `code` varchar(128) NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `emailtbl`
--

CREATE TABLE IF NOT EXISTS `emailtbl` (
  `fkUsername` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL,
  `announcements` tinyint(4) NOT NULL DEFAULT '1',
  `fromMods` tinyint(1) NOT NULL DEFAULT '1',
  `friendBooth` tinyint(1) NOT NULL DEFAULT '0',
  `boothComment` tinyint(1) NOT NULL DEFAULT '0',
  `mention` tinyint(1) NOT NULL DEFAULT '0',
  `friendRequest` tinyint(1) NOT NULL DEFAULT '0',
  `friendAccept` tinyint(1) NOT NULL DEFAULT '0',
  `newPM` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fkUsername`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `frequencytbl`
--

CREATE TABLE IF NOT EXISTS `frequencytbl` (
  `fkUsername` varchar(32) NOT NULL,
  `hour` smallint(2) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '0',
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`fkUsername`,`hour`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `friendstbl`
--

CREATE TABLE IF NOT EXISTS `friendstbl` (
  `fkUsername` varchar(32) NOT NULL,
  `fkFriendname` varchar(32) NOT NULL,
  `ignored` tinyint(1) NOT NULL DEFAULT '0',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fkUsername`,`fkFriendname`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='unidirectional friendship pairs';

-- --------------------------------------------------------

--
-- Table structure for table `groupstbl`
--

CREATE TABLE IF NOT EXISTS `groupstbl` (
  `pkGroupNumber` int(32) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(32) NOT NULL,
  PRIMARY KEY (`pkGroupNumber`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups_userstbl`
--

CREATE TABLE IF NOT EXISTS `groups_userstbl` (
  `fkGroupName` varchar(32) NOT NULL,
  `fkUsername` varchar(32) NOT NULL,
  `joinDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`fkGroupName`,`fkUsername`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hackattemptstbl`
--

CREATE TABLE IF NOT EXISTS `hackattemptstbl` (
  `ip` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fkDismisserName` varchar(32) NOT NULL,
  PRIMARY KEY (`ip`,`datetime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ignorestbl`
--

CREATE TABLE IF NOT EXISTS `ignorestbl` (
  `fkUsername` varchar(32) NOT NULL COMMENT 'User X',
  `fkIgnoredName` varchar(32) NOT NULL COMMENT 'The user being ignored by user X ',
  PRIMARY KEY (`fkUsername`,`fkIgnoredName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contains one way relationships between users and the users they ignore.';

-- --------------------------------------------------------

--
-- Table structure for table `likes_boothstbl`
--

CREATE TABLE IF NOT EXISTS `likes_boothstbl` (
  `fkBoothNumber` int(11) NOT NULL,
  `fkUsername` varchar(32) NOT NULL,
  `value` tinyint(4) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fkBoothNumber`,`fkUsername`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `likes_commentstbl`
--

CREATE TABLE IF NOT EXISTS `likes_commentstbl` (
  `fkCommentNumber` int(11) NOT NULL,
  `fkUsername` varchar(32) NOT NULL,
  `value` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fkCommentNumber`,`fkUsername`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `like_values`
--

CREATE TABLE IF NOT EXISTS `like_values` (
  `value` tinyint(4) NOT NULL,
  PRIMARY KEY (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `locationstbl`
--

CREATE TABLE IF NOT EXISTS `locationstbl` (
  `location` varchar(8) NOT NULL,
  `val` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='A mapping of locations to integers.  Used in mentionstbl';

-- --------------------------------------------------------

--
-- Table structure for table `logintbl`
--

CREATE TABLE IF NOT EXISTS `logintbl` (
  `usernumber` int(32) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `displayname` varchar(32) NOT NULL,
  `password` varchar(128) NOT NULL,
  `isBanned` int(11) NOT NULL DEFAULT '0',
  `isDisabled` int(11) NOT NULL DEFAULT '0',
  `joinDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hasIcon` tinyint(1) NOT NULL DEFAULT '0',
  `lastonline` datetime NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `ip` varchar(32) NOT NULL,
  `attempts` int(2) NOT NULL,
  `restorecode` varchar(32) NOT NULL,
  `defaultPage` enum('ALL','BOOTHS','TODAY') NOT NULL,
  `nextIndex` int(32) NOT NULL DEFAULT '0',
  `zone` varchar(64) NOT NULL DEFAULT 'UTC',
  `iconext` varchar(5) NOT NULL DEFAULT 'jpg',
  PRIMARY KEY (`usernumber`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=556 ;

-- --------------------------------------------------------

--
-- Table structure for table `mentionstbl`
--

CREATE TABLE IF NOT EXISTS `mentionstbl` (
  `fkMentionerName` varchar(32) NOT NULL,
  `fkMentionedName` varchar(32) NOT NULL,
  `fkIndex` int(11) NOT NULL,
  `fkBoothNumber` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hasBeenViewed` tinyint(1) NOT NULL DEFAULT '0',
  `location` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`fkMentionerName`,`fkMentionedName`,`fkIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `modactivitytbl`
--

CREATE TABLE IF NOT EXISTS `modactivitytbl` (
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pkEventId` int(11) NOT NULL AUTO_INCREMENT,
  `fkModeratorUsername` varchar(32) NOT NULL,
  `description` varchar(1000) NOT NULL,
  PRIMARY KEY (`pkEventId`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=201 ;

-- --------------------------------------------------------

--
-- Table structure for table `namesitetbl`
--

CREATE TABLE IF NOT EXISTS `namesitetbl` (
  `fkUsername` varchar(32) NOT NULL,
  `sitename` varchar(32) NOT NULL,
  `win` smallint(6) NOT NULL,
  PRIMARY KEY (`fkUsername`,`sitename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `newstbl`
--

CREATE TABLE IF NOT EXISTS `newstbl` (
  `pkIndex` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A unique index to identify the news story',
  `fkUsername` varchar(32) NOT NULL COMMENT 'The user that posted the story',
  `title` varchar(256) NOT NULL COMMENT 'The title of the news article',
  `body` varchar(4086) NOT NULL COMMENT 'The body of the news article',
  `postTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pkIndex`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='News posts made by moderators' AUTO_INCREMENT=87 ;

-- --------------------------------------------------------

--
-- Table structure for table `news_commentstbl`
--

CREATE TABLE IF NOT EXISTS `news_commentstbl` (
  `pkCommentNumber` int(32) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `fkNumber` int(11) NOT NULL,
  `fkUsername` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `commentBody` varchar(10000) NOT NULL,
  `hasPhoto` tinyint(1) NOT NULL DEFAULT '0',
  `imageHeightProp` double NOT NULL DEFAULT '0.75',
  `adminPost` tinyint(1) NOT NULL DEFAULT '0',
  `zone` varchar(32) NOT NULL DEFAULT 'UTC_A',
  `extension` varchar(5) NOT NULL DEFAULT 'na',
  PRIMARY KEY (`pkCommentNumber`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;

-- --------------------------------------------------------

--
-- Table structure for table `newuserstbl`
--

CREATE TABLE IF NOT EXISTS `newuserstbl` (
  `fkUsername` varchar(32) NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phonekeystbl`
--

CREATE TABLE IF NOT EXISTS `phonekeystbl` (
  `fkUsername` varchar(30) NOT NULL,
  `fkPhoneID` varchar(128) NOT NULL,
  `key` varchar(64) NOT NULL,
  PRIMARY KEY (`fkUsername`,`fkPhoneID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pmcopy`
--

CREATE TABLE IF NOT EXISTS `pmcopy` (
  `pkPMID` int(32) NOT NULL AUTO_INCREMENT,
  `fromUsername` varchar(32) NOT NULL,
  `toUsername` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(2048) NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pkPMID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=236 ;

-- --------------------------------------------------------

--
-- Table structure for table `polltbl`
--

CREATE TABLE IF NOT EXISTS `polltbl` (
  `fkUsername` varchar(32) NOT NULL,
  `pollname` varchar(32) NOT NULL,
  `answer` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`fkUsername`,`pollname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `privatemsgtbl`
--

CREATE TABLE IF NOT EXISTS `privatemsgtbl` (
  `pkPMID` int(32) NOT NULL AUTO_INCREMENT,
  `fromUsername` varchar(32) NOT NULL,
  `toUsername` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` longblob NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pkPMID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2858 ;

-- --------------------------------------------------------

--
-- Table structure for table `privatemsgtbl_copy`
--

CREATE TABLE IF NOT EXISTS `privatemsgtbl_copy` (
  `pkPMID` int(32) NOT NULL AUTO_INCREMENT,
  `fromUsername` varchar(32) NOT NULL,
  `toUsername` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(2048) NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pkPMID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `registertbl`
--

CREATE TABLE IF NOT EXISTS `registertbl` (
  `code` varchar(128) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(256) NOT NULL,
  `email` varchar(64) NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `expiry` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `remembertbl`
--

CREATE TABLE IF NOT EXISTS `remembertbl` (
  `cookie` varchar(32) NOT NULL,
  `fkUsername` varchar(32) NOT NULL,
  `expiredate` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `removedbooths`
--

CREATE TABLE IF NOT EXISTS `removedbooths` (
  `pkNumber` int(11) NOT NULL,
  `imageTitle` varchar(32) NOT NULL,
  `imageHeightProp` double NOT NULL,
  `blurb` varchar(10000) NOT NULL,
  `datetime` datetime NOT NULL,
  `fkUsername` varchar(32) NOT NULL,
  `fkRemoverName` varchar(32) NOT NULL,
  `token` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `security_values`
--

CREATE TABLE IF NOT EXISTS `security_values` (
  `val` tinyint(4) NOT NULL,
  PRIMARY KEY (`val`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Values to be used by userclassificationtbl';

-- --------------------------------------------------------

--
-- Table structure for table `sitemsgtbl`
--

CREATE TABLE IF NOT EXISTS `sitemsgtbl` (
  `fkUsername` varchar(32) NOT NULL,
  `area` varchar(32) NOT NULL,
  UNIQUE KEY `fkUsername` (`fkUsername`,`area`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sitenamepairstbl`
--

CREATE TABLE IF NOT EXISTS `sitenamepairstbl` (
  `pkKey` int(11) NOT NULL AUTO_INCREMENT,
  `name1` varchar(32) NOT NULL,
  `name2` varchar(32) NOT NULL,
  PRIMARY KEY (`pkKey`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Table structure for table `sitenamevotedtbl`
--

CREATE TABLE IF NOT EXISTS `sitenamevotedtbl` (
  `fkUsername` varchar(32) NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sitenoticestbl`
--

CREATE TABLE IF NOT EXISTS `sitenoticestbl` (
  `pkNum` int(32) NOT NULL AUTO_INCREMENT COMMENT 'a unique ID',
  `fkUsernumber` int(32) NOT NULL COMMENT 'the usernumber of the person who added the notice',
  `message` varchar(128) NOT NULL,
  `url` varchar(32) NOT NULL,
  `expiry` datetime NOT NULL COMMENT 'the time after which this notice will no longer be displayed',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'the time at which the message was posted',
  PRIMARY KEY (`pkNum`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `suggestiontbl`
--

CREATE TABLE IF NOT EXISTS `suggestiontbl` (
  `fkUsername` varchar(32) NOT NULL,
  `suggestion` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testtbl`
--

CREATE TABLE IF NOT EXISTS `testtbl` (
  `val` varchar(256) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userlikestbl`
--

CREATE TABLE IF NOT EXISTS `userlikestbl` (
  `fkUsername` varchar(32) NOT NULL,
  `lastCalculated` date NOT NULL,
  `numLikes` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fkUsername`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usersabouttbl`
--

CREATE TABLE IF NOT EXISTS `usersabouttbl` (
  `fkUsername` varchar(32) NOT NULL,
  `about` varchar(4096) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usersbannedtbl`
--

CREATE TABLE IF NOT EXISTS `usersbannedtbl` (
  `fkUsername` varchar(32) NOT NULL,
  `fkModeratorUsername` varchar(32) NOT NULL,
  `reason` varchar(128) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usersdevstbl`
--

CREATE TABLE IF NOT EXISTS `usersdevstbl` (
  `fkUsername` varchar(32) NOT NULL,
  `hash` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Users who are developers';

-- --------------------------------------------------------

--
-- Table structure for table `usersecuritytbl`
--

CREATE TABLE IF NOT EXISTS `usersecuritytbl` (
  `fkUsername` varchar(32) NOT NULL,
  `security` enum('NORMAL','SECURE','SUPER') NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usersprivacytbl`
--

CREATE TABLE IF NOT EXISTS `usersprivacytbl` (
  `fkUsername` varchar(64) NOT NULL,
  `changeDateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `privacyDescriptor` varchar(16) NOT NULL COMMENT 'one of: private, public, semi-public',
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userspublictbl`
--

CREATE TABLE IF NOT EXISTS `userspublictbl` (
  `fkUsername` varchar(32) NOT NULL,
  `fkPassword` varchar(256) NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usersreportedtbl`
--

CREATE TABLE IF NOT EXISTS `usersreportedtbl` (
  `fkUsername` varchar(32) NOT NULL,
  `fkReporterUsername` varchar(32) NOT NULL,
  `fkIndex` varchar(32) NOT NULL,
  `reason` varchar(32) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fkUsername`,`fkReporterUsername`,`fkIndex`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userssemipublictbl`
--

CREATE TABLE IF NOT EXISTS `userssemipublictbl` (
  `fkUsername` varchar(32) NOT NULL,
  `fkPassword` varchar(256) NOT NULL,
  PRIMARY KEY (`fkUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userssuspendedtbl`
--

CREATE TABLE IF NOT EXISTS `userssuspendedtbl` (
  `fkUsername` varchar(32) NOT NULL,
  `fkModeratorUsername` varchar(32) NOT NULL,
  `fkIndex` varchar(256) NOT NULL,
  `reason` varchar(128) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `likes_boothstbl`
--
ALTER TABLE `likes_boothstbl`
  ADD CONSTRAINT `likes_boothstbl_ibfk_1` FOREIGN KEY (`value`) REFERENCES `like_values` (`value`);

--
-- Constraints for table `likes_commentstbl`
--
ALTER TABLE `likes_commentstbl`
  ADD CONSTRAINT `likes_commentstbl_ibfk_1` FOREIGN KEY (`value`) REFERENCES `like_values` (`value`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
